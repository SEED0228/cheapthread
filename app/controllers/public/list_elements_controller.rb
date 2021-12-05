# frozen_string_literal: true

module Public
  class ListElementsController < Public::Base
    before_action :authenticate_end_user!, only: %i[new create update destroy]
    def new
      @list = List.find(params[:list_id])
      @list_elements = @list.list_elements.build
    end

    def create
      @list = List.find(params[:list_id])
      if @list.update(list_params)
        redirect_to list_path(@list), notice: 'リスト作成に成功しました'
      else
        render 'new'
      end
    end

    def update; end

    def destroy; end

    def import
      Rails.logger.debug params[:list_id]
      @list = List.find(params[:list_id])
      ListElement.transaction do
        ListElement.import!(params[:file], @list)
      end
    rescue StandardError => e
      Rails.logger.debug e
      redirect_to new_list_list_element_path(@list), notice: "インポートに失敗しました#{e}"
    end

    private

    def list_params
      params.require(:list).permit(:title, :introduction, :contains_calorie, :contains_price, :is_public,
                                   list_elements_attributes: %i[_destroy id name price introduction calorie])
    end
  end
end
