# frozen_string_literal: true

module Public
  class EndUsersController < Public::Base
    def index
      @end_users = EndUser.all
      @list = List.new
    end

    def show
      @end_user = EndUser.find(params[:id])
      @list = List.new
      @lists = if current_end_user == @end_user
                 @end_user.lists
               else
                 @end_user.lists.where(is_public: true)
               end
    end

    def edit
      @end_user = EndUser.find(params[:id])
      redirect_to end_user_path(current_end_user), notice: '他者のユーザを編集できません' if @end_user != current_end_user
    end

    def update
      @end_user = EndUser.find(params[:id])
      if @end_user.update(end_user_params)
        redirect_to end_user_path(params[:id]), notice: '正常に編集できました'
      else
        render 'edit'
      end
    end

    private

    def end_user_params
      params.require(:end_user).permit(:name, :email, :profile_image)
    end
  end
end
