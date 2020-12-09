class Public::HomeController < Public::Base
  def home
    @lists = List.all
    @list = List.new
  end
end
