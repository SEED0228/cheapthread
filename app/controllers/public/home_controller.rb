class Public::HomeController < Public::Base
  def home
    @lists = List.where(is_public: true).order(id: "DESC")
    @list = List.new
  end

  def sort
    sort_num = params[:sort_num].to_i
    
    case sort_num
    when 1 then
      @lists = List.where(is_public: true).order(id: "DESC")
    when 2 then
      @lists = List.where(is_public: true)
    when 3 then
      @lists = List.where(is_public: true).order(view_counter: "DESC")
    when 4 then
      @lists = List.where(is_public: true).order(view_counter: "ASC")
    end
  end


end
