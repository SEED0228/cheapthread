# frozen_string_literal: true

class CheapThread < ApplicationRecord
  belongs_to :end_user, optional: true
  belongs_to :nanj, optional: true
  belongs_to :list
  has_many :thread_comments, dependent: :destroy
end
