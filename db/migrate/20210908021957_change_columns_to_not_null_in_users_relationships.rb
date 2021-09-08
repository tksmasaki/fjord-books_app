# frozen_string_literal: true

class ChangeColumnsToNotNullInUsersRelationships < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users_relationships, :follower_id, false
    change_column_null :users_relationships, :following_id, false
  end
end
