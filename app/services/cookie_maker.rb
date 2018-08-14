# frozen_string_literal: true

require 'biscotti'

class CookieMaker
  attr_reader :letters, :cookie

  def initialize(letters)
    @letters = letters
  end

  def call
    @cookie = CookieFinder.new(letters).call.cookie

    return self if cookie.persisted?

    dictionary = Biscotti.load_dictionary(Rails.root.join('data', 'dictionaries', 'basic.lst').freeze)

    cookie.words = Biscotti.find_words(letters, dictionary: dictionary, min_word_length: 2)

    cookie.save!

    self
  end
end
