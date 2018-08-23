# frozen_string_literal: true

class AddLettersFormatFunction < ActiveRecord::Migration[5.2]
  def down
    execute(<<~SQL)
      drop function if exists letters_format (text);
    SQL
  end

  def up
    execute(<<~SQL)
      create or replace function letters_format (text)
        returns text
      as $$
      select
        array_to_string(array_agg(letters_array.letter), '') as letters
      from (
        select
          unnest(string_to_array(lower(regexp_replace($1, '[[:space:]]', '')), null)) as letter
        order by
          letter asc) as letters_array;
      $$
      language sql strict immutable;
    SQL
  end
end
