# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user

  scope :order_by_latest, -> { order('created_at DESC, id') }
  scope :with_author_name, -> { joins(:user).select('reports.*, email, name AS username') }

  def author_name
    # Report.with_author_nameを呼び出さずにインスタンス生成した場合に対応
    return '' unless respond_to?(:username)

    username.empty? ? email : username
  end
end
