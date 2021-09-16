# frozen_string_literal: true

module BelongToUser
  extend ActiveSupport::Concern

  included do
    scope :with_username, -> { joins(:user).select("#{name.downcase.pluralize}.*, email, name AS username") }

    def author_name
      # BelongToUser.with_usernameを呼び出さずにインスタンス生成した場合に対応
      return '' unless respond_to?(:username)

      username.empty? ? email : username
    end
  end
end
