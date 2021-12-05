# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :end_user
  has_many :list_elements, dependent: :destroy
  accepts_nested_attributes_for :list_elements, allow_destroy: true
  validates :title, presence: true
  scope :is_public, -> { where(is_public: true) }

  def turn_default_gacha(num)
    elements = []
    num.times { elements.push(list_elements.sample) }
    elements
  end

  def turn_price_gacha(max_price)
    total_price = 0
    elements = []
    loop do
      elements_all = list_elements.where('price <= ?', max_price - total_price)
      break if elements_all.count.zero?

      element = elements_all.sample
      elements.push(element)
      total_price += element.price
    end
    [total_price, elements]
  end

  def turn_calorie_gacha(max_calorie)
    total_calorie = 0
    elements = []
    loop do
      elements_all = list_elements.where('calorie <= ?', max_calorie - total_calorie)
      break if elements_all.count.zero?

      element = elements_all.sample
      elements.push(element)
      total_calorie += element.calorie
    end
    [total_calorie, elements]
  end
end
