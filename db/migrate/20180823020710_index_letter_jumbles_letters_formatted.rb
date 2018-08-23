# frozen_string_literal: true

class IndexLetterJumblesLettersFormatted < ActiveRecord::Migration[5.2]
  def down
    execute(<<-SQL)
    drop index if exists index_letter_jumbles_letters_formatted;
    SQL
  end

  def up
    execute(<<~SQL)
      create index if not exists index_letter_jumbles_letters_formatted on letter_jumbles
        using btree (letters_format (letters));
    SQL
  end
end
