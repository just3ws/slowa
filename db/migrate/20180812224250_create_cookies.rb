# frozen_string_literal: true

class CreateLetterJumbles < ActiveRecord::Migration[5.2]
  def change
    create_table :letter_jumbles do |t|
      t.string :letters, using: 'gin', null: false, unique: true
      t.string :words, default: [], array: true
      t.integer :version

      t.timestamps
    end
  end
end
