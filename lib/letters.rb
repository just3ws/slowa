# frozen_string_literal: true

module Letters
  module_function

  def format(letters)
    letters.downcase.scan(/[a-z]/i).sort.join.freeze
  end
end
