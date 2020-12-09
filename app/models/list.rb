class List < ApplicationRecord
    belongs_to :end_user
    has_many :list_elements, dependent: :destroy
end
