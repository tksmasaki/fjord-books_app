# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
