# frozen_string_literal: true

class ListElement < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  validate :price_presence
  validate :calorie_presence

  def price_presence
    errors.add(:base, "price can't be blank or must be 1 or more") if list.contains_price && (price || 0) <= 0
  end

  def calorie_presence
    errors.add(:base, "calorie can't be blank or must be 1 or more") if list.contains_calorie && (calorie || 0) <= 0
  end
end
