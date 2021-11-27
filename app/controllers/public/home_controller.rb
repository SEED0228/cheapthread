# frozen_string_literal: true

module Public
  class HomeController < Public::Base
    def home
      @lists = List.where(is_public: true).order(id: 'DESC')
      @list = List.new
    end

    def sort
      case params[:sort_num].to_i
      when 1
        @lists = List.where(is_public: true).order(id: 'DESC')
      when 2
        @lists = List.where(is_public: true).order(id: 'ASC')
      when 3
        @lists = List.where(is_public: true).order(view_counter: 'DESC')
      when 4
        @lists = List.where(is_public: true).order(view_counter: 'ASC')
      end
    end
  end
end
