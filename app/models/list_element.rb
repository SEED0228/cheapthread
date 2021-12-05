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

  def self.import!(file, list)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      element = list.list_elements.new
      # CSVからデータを取得し、設定する
      element.attributes = row.to_hash.slice(*updatable_attributes)
      Rails.logger.debug element
      Rails.logger.debug row
      element.save!
    end
  end

  def self.updatable_attributes
    %w[id name price calorie description]
  end
end
