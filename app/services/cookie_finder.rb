# frozen_string_literal: true

require 'biscotti/letters'

class CookieFinder
  attr_reader :letters, :cookie

  def initialize(letters)
    @letters = letters
  end

  def call
    @cookie = Cookie.find_or_initialize_by(letters: Biscotti::Letters.format(letters))

    self
  end
end
