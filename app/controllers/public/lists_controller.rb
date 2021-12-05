# frozen_string_literal: true

module Public
  class ListsController < Public::Base
    before_action :authenticate_end_user!, only: %i[edit create update destroy]

    def show
      @list = List.find(params[:id])
      redirect_to root_path, notice: 'このリストは非公開です' if @list.is_public == false && current_end_user != @list.end_user
      @list_new = List.new
      @end_user = @list.end_user
      @list_elements = @list.list_elements
      @list.view_counter += 1
      @list.save!
    end

    def create
      @list = List.new(list_params)
      @list.end_user_id = current_end_user.id
      if @list.save
        redirect_to list_path(@list)
      else
        @lists = List.all
        render 'public/home/home'
      end
    end

    def edit
      @list = List.find(params[:id])
    end

    def update
      @list = List.find(params[:id])
      if @list.update(list_params)
        redirect_to list_path(@list)
      else
        render 'edit'
      end
    end

    def search
      @sort_num = params[:sort_num].to_i
      @search_word = params[:search_word]
      @lists = if @search_word.nil?
                 List.where(is_public: true)
               else
                 List.where(is_public: true).where('title like ?', "%#{@search_word}%")
               end
      @lists = sort_search_list(@sort_num, @lists)
    end

    def destroy
      @list = List.find(params[:id])
      @list.destroy!
      redirect_to root_path, notice: '正常に削除されました'
    end

    private

    def list_params
      params.require(:list).permit(:title, :introduction, :add_calorie, :add_price_element, :is_public)
    end

    def sort_search_list(sort_num, lists)
      case sort_num
      when 1
        lists.order(id: 'DESC')
      when 2
        lists.order(id: 'ASC')
      when 3
        lists.order(view_counter: 'DESC')
      when 4
        lists.order(view_counter: 'ASC')
      end
    end
  end
end
