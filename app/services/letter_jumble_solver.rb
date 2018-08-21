# frozen_string_literal: true

require 'biscotti'

class LetterJumbleSolver
  attr_reader :letters, :letter_jumble

  def initialize(letters:)
    @letters = letters
  end

  def call
    @letter_jumble = LetterJumbleFinder.new(letters: letters).call.letter_jumble

    return self if letter_jumble.persisted? || letter_jumble.invalid?

    dictionary = Biscotti.load_dictionary(Rails.root.join('data', 'dictionaries', 'basic.lst').freeze)

    letter_jumble.words = Biscotti.find_words(letters, dictionary: dictionary, min_word_length: 2)

    letter_jumble.save!

    self
  end
end
