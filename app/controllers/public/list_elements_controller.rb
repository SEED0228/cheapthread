class Public::ListElementsController < Public::Base
  def new
    @list = List.find(params[:list_id])
    @list_elements = @list.list_elements.build
  end
  def create
    @list = List.find(params[:list_id])
    @list.update(list_params)
    #if @list.save
    #  redirect_to list_path(@list)
    #else
    #  render 'new'
    #end
    redirect_to list_path(@list)
  end
  def update
  end
  def destroy
  end
  private
  def list_params
    params.require(:list).permit(:title, :introduction, :add_calorie, :add_price_element, :is_public, list_elements_attributes: [:_destroy, :id, :name, :price, :introduction, :calorie])
  end
end
