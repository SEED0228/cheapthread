class Public::ListsController < Public::Base
  before_action :authenticate_end_user!, only: [:edit,:create,:update,:destroy]
  def index
  end

  def show
    @list = List.find(params[:id])
    if @list.is_public == false && current_end_user != @list.end_user
       redirect_to root_path, notice: "このリストは非公開です"
    end
    @list_new = List.new
    @end_user = @list.end_user
    @list_elements = @list.list_elements
    @list.view_counter += 1
    @list.save
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
      render "edit"
    end
  end

private
  def list_params
    params.require(:list).permit(:title, :introduction, :add_calorie, :add_price_element, :is_public)
  end
end
