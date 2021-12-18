# frozen_string_literal: true

class CheapThread < ApplicationRecord
  belongs_to :end_user, optional: true
  belongs_to :nanj, optional: true
  belongs_to :list
  has_many :thread_comments, dependent: :destroy

  validates :title, presence: true

  def add_comment_number
    update(comment_number: comment_number + 1)
  end

  def create_anker_comments(num)
    while num > comment_number
      comment = thread_comments.new(comment: list.list_elements.sample.name, number: comment_number + 1,
                                    name: initial_name)
      comment.set_dummy_user_id
      comment.save!
      add_comment_number
    end
  end

  def generate_twitter_link
    tweet_link = "https://twitter.com/intent/tweet?text=#{title}%0A%0A"
    tweet_link += '%23ご注文は安価ですか？%0A'
    tweet_link += "https://www.cheapthread.jp/threads/#{id}"
    URI.encode_www_form_component tweet_link
    tweet_link
  end
end
