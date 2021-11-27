# frozen_string_literal: true

module ApplicationHelper
  def price_permission(list)
    list.list_elements.each do |list_element|
      return false if list_element.price.nil? || list_element.price.zero?
    end
    true
  end

  def calorie_permission(list)
    list.list_elements.each do |list_element|
      return false if list_element.calorie.nil? || list_element.calorie.zero?
    end
    true
  end
end
