# frozen_string_literal: true

class Nanj < ApplicationRecord
  has_many :cheap_threads, dependent: :destroy
  has_many :thread_comments, dependent: :destroy

  def update_random_number
    update(random_number: SecureRandom.hex(8))
  end
end
