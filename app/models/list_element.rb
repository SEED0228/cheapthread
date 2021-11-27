# frozen_string_literal: true

class ListElement < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
end
