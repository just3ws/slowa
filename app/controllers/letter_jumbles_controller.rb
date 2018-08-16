# frozen_string_literal: true

class LetterJumblesController < ApplicationController
  def create; end

  def show
    letters = params.require(:letters)

    letter_jumble = LetterJumbleSolver.new(letters: letters).call.letter_jumble

    render json: LetterJumbleSerializer.new(letter_jumble)
  end
end
