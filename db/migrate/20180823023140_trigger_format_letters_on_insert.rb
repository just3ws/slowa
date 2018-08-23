# frozen_string_literal: true

class TriggerFormatLettersOnInsert < ActiveRecord::Migration[5.2]
  def down
    execute(<<~SQL)
      drop trigger if exists trigger_ensure_letters_formatted on letter_jumbles;
      drop function if exists ensure_letters_formatted ();
    SQL
  end

  def up
    execute(<<~SQL)
      drop trigger if exists trigger_ensure_letters_formatted on letter_jumbles;
      drop function if exists ensure_letters_formatted ();

      create or replace function ensure_letters_formatted ()
        returns trigger
      as '
       begin
         if new.letters is not null and new.letters <> '''' then
           new.letters := letters_format(new.letters);
         end if;
         return new;
       end'
      language 'plpgsql';

      create trigger trigger_ensure_letters_formatted before insert on letter_jumbles for each ROW execute procedure ensure_letters_formatted ();
    SQL
  end
end
