# frozen_string_literal: true

module BelongsToUser
  extend ActiveSupport::Concern

  included do
    def author_name
      user.name.empty? ? user.email : user.name
    end
  end
end
