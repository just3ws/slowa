# frozen_string_literal: true

require 'letters'

class LetterJumbleFinder
  attr_reader :letters, :data

  def initialize(letters:)
    @letters = letters
  end

  def call
    @data = LetterJumble.find_or_initialize_by(letters: Letters.format(letters))

    self
  end
end
