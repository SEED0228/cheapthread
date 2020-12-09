class Public::ListsController < Public::Base
  def index
  end

  def show
    @list = List.find(params[:id])
    @listnew = List.new
    @end_user = @list.end_user
    @list_elements = @list.list_elements
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
  end

  def update
  end

private
  def list_params
    params.require(:list).permit(:title, :introduction, :add_calorie, :add_price_element, :is_public)
  end
end
