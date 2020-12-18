class Public::GachasController < Public::Base
  def default
    @list = List.find(params[:list_id])
    @end_user = @list.end_user
  end

  def price
    @list = List.find(params[:list_id])
    @end_user = @list.end_user
    if price_permission(@list) == false
      redirect_to root_path, notice: 'このリストは〇円ガチャできません'
    end

  end

  def calorie
    @list = List.find(params[:list_id])
    @end_user = @list.end_user
    if calorie_permission(@list) == false
      redirect_to root_path, notice: 'このリストは〇kcalガチャできません'
    end

  end

  def default_create
    @num = params[:time].to_i
    @list = List.find(params[:list_id])
    list_elements_all = @list.list_elements
    @list_elements = []
    if @num <= 0
      redirect_to list_gacha_default_path, notice: '入力が不正です'
    end
    # ガチャ処理+ツイートリンク生成
    @tweet_link = "https://twitter.com/intent/tweet?text=" + @list.title + @num.to_s + "連ガチャ"
    @num.times{
      list_element = list_elements_all.sample
      @list_elements.push(list_element)
      @tweet_link += "%0A"+list_element.name
    }
    URI.encode @tweet_link

  end

  def price_create
    @max_price = params[:price].to_i
    @list = List.find(params[:list_id])
    if @max_price <= 0
      redirect_to list_gacha_default_path, notice: '入力が不正です'
    end
    # ガチャ処理+ツイートリンク生成
    @total_price = 0
    @list_elements = []
    @tweet_link = "https://twitter.com/intent/tweet?text=" + @list.title + @max_price.to_s + "円ガチャ"
    while true do
      list_elements_all = @list.list_elements.where("price <= ?", @max_price - @total_price)
      if list_elements_all.count == 0
        break
      end
      list_element = list_elements_all.sample
      @list_elements.push(list_element)
      @tweet_link += "%0A"+list_element.name+'(￥'+list_element.price.to_s+')'
      @total_price += list_element.price
    end
    @tweet_link += "%0A"+"計￥"+@total_price.to_s
    URI.encode @tweet_link

  end

  def calorie_create
    @max_calorie = params[:calorie].to_i
    @list = List.find(params[:list_id])
    if @max_calorie <= 0
      redirect_to list_gacha_default_path, notice: '入力が不正です'
    end
    # ガチャ処理+ツイートリンク生成
    @total_calorie = 0
    @list_elements = []
    @tweet_link = "https://twitter.com/intent/tweet?text=" + @list.title + @max_calorie.to_s + "kcalガチャ"
    while true do
      list_elements_all = @list.list_elements.where("calorie <= ?", @max_calorie - @total_calorie)
      if list_elements_all.count == 0
        break
      end
      list_element = list_elements_all.sample
      @list_elements.push(list_element)
      @tweet_link += "%0A"+list_element.name+'('+list_element.calorie.to_s+'kcal)'
      @total_calorie += list_element.calorie
    end
    @tweet_link += "%0A"+"計"+@total_calorie.to_s+"kcal"
    URI.encode @tweet_link
  end
  private
  def price_permission(list)
      list.list_elements.each do |list_element|
          if list_element.price.nil? || list_element.price == 0
              return false
          end
      end
      return true
  end

  def calorie_permission(list)
      list.list_elements.each do |list_element|
          if list_element.calorie.nil? || list_element.calorie == 0
              return false
          end
      end
      return true
  end

  def gacha_params
    params.permit(:price,:calorie,:time)
  end
end
