# frozen_string_literal: true

class ThreadComment < ApplicationRecord
  belongs_to :end_user, optional: true
  belongs_to :cheap_thread
  belongs_to :nanj, optional: true

  validates :comment, presence: true

  def set_user_id
    ip = nanj.ip_address
    thread_title = cheap_thread.title
    random = nanj.random_number
    self.user_id = generate_user_id(ip, random, thread_title)
  end

  def set_dummy_user_id
    ip = "#{rand(256)}.#{rand(256)}.#{rand(256)}.#{rand(256)}"
    thread_title = cheap_thread.title
    random = SecureRandom.hex(8)
    self.user_id = generate_user_id(ip, random, thread_title)
  end

  def generate_user_id(ip, random, thread_title)
    day = Time.zone.today.day.to_s
    anonymous_name = ip + day + thread_title + random
    Digest::MD5.hexdigest(anonymous_name).slice(0..8)
  end

  def max_anker
    max = ankers.max
    max.nil? ? -1 : max
  end

  def ankers
    comment.scan(/>>(\d+)/).flatten.map(&:to_i)
  end
end
