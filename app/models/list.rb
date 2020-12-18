class List < ApplicationRecord
    belongs_to :end_user
    has_many :list_elements, dependent: :destroy
    accepts_nested_attributes_for :list_elements, allow_destroy: true
    validates :title, presence: true
end
