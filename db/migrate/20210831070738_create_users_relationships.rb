# frozen_string_literal: true

class CreateUsersRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :users_relationships do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
    add_index :users_relationships, :follower_id
    add_index :users_relationships, :following_id
    add_index :users_relationships, %i[follower_id following_id], unique: true
  end
end
