# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :user_icon
  validates :user_icon, content_type: %w[image/jpeg image/png image/gif]

  def display_user_icon(size:)
    user_icon.variable? ? user_icon.variant(resize_to_limit: [size, size]) : user_icon
  end
end
