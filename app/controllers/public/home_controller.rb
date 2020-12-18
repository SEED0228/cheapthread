class Public::HomeController < Public::Base
  def home
    @lists = List.where(is_public: true)
    @list = List.new
  end
end
