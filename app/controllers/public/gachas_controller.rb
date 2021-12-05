# frozen_string_literal: true

module Public
  class GachasController < Public::Base
    def default
      @list = List.find(params[:list_id])
      @end_user = @list.end_user
      redirect_to root_path, notice: 'このリストは非公開です' if @list.is_public == false && @list.end_user != current_end_user
    end

    def price
      @list = List.find(params[:list_id])
      @end_user = @list.end_user
      if @list.is_public == false && @list.end_user != current_end_user
        redirect_to root_path, notice: 'このリストは非公開です'
        return
      end
      redirect_to root_path, notice: 'このリストは〇円ガチャできません' if @list.ready_to_turn_price_gacha?
    end

    def calorie
      @list = List.find(params[:list_id])
      @end_user = @list.end_user
      if @list.is_public == false && @list.end_user != current_end_user
        redirect_to root_path, notice: 'このリストは非公開です'
        return
      end
      redirect_to root_path, notice: 'このリストは〇kcalガチャできません' if @list.ready_to_turn_calorie_gacha?
    end

    def default_create
      @num = params[:time].to_i
      @list = List.find(params[:list_id])
      redirect_to list_gacha_default_path, notice: '入力が不正です' if @num <= 0
      # ガチャ処理+ツイートリンク生成
      @list_elements = @list.turn_default_gacha(@num)
      @tweet_link = generate_default_twitter_link("#{@list.title}#{@num}連ガチャ", @list_elements, @list)
    end

    def price_create
      @max_price = params[:price].to_i
      @list = List.find(params[:list_id])
      redirect_to list_gacha_default_path, notice: '入力が不正です' if @max_price <= 0
      # ガチャ処理+ツイートリンク生成
      @total_price, @list_elements = @list.turn_price_gacha(@max_price)
      @tweet_link = generate_price_twitter_link("#{@list.title}#{@max_price}円ガチャ", @list_elements, @list, @total_price)
    end

    def calorie_create
      @max_calorie = params[:calorie].to_i
      @list = List.find(params[:list_id])
      redirect_to list_gacha_default_path, notice: '入力が不正です' if @max_calorie <= 0
      # ガチャ処理+ツイートリンク生成
      @total_calorie, @list_elements = @list.turn_calorie_gacha(@max_calorie)
      @tweet_link = generate_calorie_twitter_link("#{@list.title}#{@max_calorie}kcalガチャ", @list_elements, @list,
                                                  @total_calorie)
    end

    private

    def gacha_params
      params.permit(:price, :calorie, :time)
    end

    def generate_default_twitter_link(title, elements, list)
      tweet_link = "https://twitter.com/intent/tweet?text=#{title}"
      elements.each do |element|
        tweet_link += "%0A#{element.name}"
      end
      tweet_link += "%0Alink:https://cheapthread.herokuapp.com/lists/#{list.id}"
      URI.encode_www_form_component tweet_link
      tweet_link
    end

    def generate_calorie_twitter_link(title, elements, list, total_calorie)
      tweet_link = "https://twitter.com/intent/tweet?text=#{title}"
      elements.each do |element|
        tweet_link += "%0A#{element.name}(#{element.calorie}kcal)"
      end
      tweet_link += "%0A計#{total_calorie}kcal"
      tweet_link += "%0Alink:https://cheapthread.herokuapp.com/lists/#{list.id}"
      URI.encode_www_form_component tweet_link
      tweet_link
    end

    def generate_price_twitter_link(title, elements, list, total_price)
      tweet_link = "https://twitter.com/intent/tweet?text=#{title}"
      elements.each do |element|
        tweet_link += "%0A#{element.name}(￥#{element.price})"
      end
      tweet_link += "%0A計￥#{total_price}"
      tweet_link += "%0Alink:https://cheapthread.herokuapp.com/lists/#{list.id}"
      URI.encode_www_form_component tweet_link
      tweet_link
    end
  end
end
