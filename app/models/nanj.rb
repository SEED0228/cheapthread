# frozen_string_literal: true

class Nanj < ApplicationRecord
  has_many :cheap_threads, dependent: :destroy
  has_many :thread_comments, dependent: :destroy
end
