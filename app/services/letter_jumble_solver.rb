# frozen_string_literal: true

require 'biscotti'

class LetterJumbleSolver
  attr_reader :letters, :data

  def initialize(letters:)
    @letters = letters
  end

  def call
    @data = LetterJumbleFinder.new(letters: letters).call.data

    return self if data.persisted? || data.invalid?

    dictionary = Biscotti.load_dictionary(Rails.root.join('data', 'dictionaries', 'basic.lst').freeze)

    data.words = Biscotti.find_words(letters, dictionary: dictionary, min_word_length: 2)

    data.save!

    self
  end
end
