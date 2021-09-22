# frozen_string_literal: true

class Report < ApplicationRecord
  include BelongsToUser

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  scope :order_by_latest, -> { order('reports.created_at DESC, reports.id') }
end
