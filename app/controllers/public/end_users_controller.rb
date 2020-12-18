class Public::EndUsersController < Public::Base
  def index
    @end_users = EndUser.all
    @list = List.new
  end

  def show
    @end_user = EndUser.find(params[:id])
    @list = List.new
    if current_end_user == @end_user
      @lists = @end_user.lists
    else
      @lists = @end_user.lists.where(is_public: true)
    end
  end

  def edit
    @end_user = EndUser.find(params[:id])
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
