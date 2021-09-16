# frozen_string_literal: true

class Comment < ApplicationRecord
  include BelongsToUser

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :comment, presence: true

  scope :order_by_oldest, -> { order('created_at, id') }
end
