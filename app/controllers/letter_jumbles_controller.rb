# frozen_string_literal: true

class LetterJumblesController < ApplicationController
  def show
    letter_jumble = LetterJumbleFinder.new(letters: letters).call.letter_jumble

    head(:not_found) && return if letter_jumble.id.blank?

    render(json: LetterJumbleSerializer.new(letter_jumble))
  end

  def create
    letter_jumble = LetterJumbleSolver.new(letters: letters).call.letter_jumble

    render json: LetterJumbleSerializer.new(letter_jumble)
  end

  protected

    def letters
      @letters ||= params.require(:letters)
    end
end
