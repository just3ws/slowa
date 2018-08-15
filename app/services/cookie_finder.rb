# frozen_string_literal: true

require 'biscotti/letters'

class LetterJumbleFinder
  attr_reader :letters, :letter_jumble

  def initialize(letters)
    @letters = letters
  end

  def call
    @letter_jumble = LetterJumble.find_or_initialize_by(letters: Biscotti::Letters.format(letters))

    self
  end
end
