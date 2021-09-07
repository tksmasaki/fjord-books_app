# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :string
    add_column :users, :postcode, :string
    add_column :users, :self_introduction, :text
  end
end
