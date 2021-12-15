# frozen_string_literal: true

class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :lists, dependent: :destroy
  has_many :thread_comments, dependent: :destroy
  has_many :cheap_threads, dependent: :destroy
end
