# frozen_string_literal: true

class ThreadComment < ApplicationRecord
  belongs_to :end_user, optional: true
  belongs_to :cheap_thread
  belongs_to :nanj, optional: true
end
