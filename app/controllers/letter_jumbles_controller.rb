# frozen_string_literal: true

class LetterJumblesController < ApplicationController
  def index
    page_length = 10

    letter_jumbles = LetterJumble
                     .order(id: :desc)
                     .limit(page_length)

    options = {
      meta: {
        total: letter_jumbles.count
      },
      links: {
        self: letter_jumbles_path
      },
      is_collection: true
    }

    render(json: LetterJumbleSerializer.new(letter_jumbles, options))
  end

  def show
    letter_jumble = LetterJumbleFinder.new(letters: letters).call.letter_jumble

    head(:not_found) && return unless letter_jumble.persisted?

    render(json: LetterJumbleSerializer.new(letter_jumble)) && return if letter_jumble.valid?
  end

  def create
    letter_jumble = LetterJumbleSolver.new(letters: letters).call.letter_jumble

    render(status: :not_acceptable, json: json_api_errors_for(letter_jumble)) && return if letter_jumble.invalid?

    render json: LetterJumbleSerializer.new(letter_jumble)
  end

  protected

  def letters
    @letters ||= params.require(:letters)
  end

  def json_api_errors_for(model)
    friendly_model_name = model.class.name.underscore.humanize

    model.errors.messages.map do |attribute, messages|
      {
        errors: messages.map do |message|
          {
            status: '406',
            source: { pointer: "/data/attributes/#{attribute}" },
            detail: "#{friendly_model_name} #{attribute} #{message}"
          }
        end
      }
    end
  end
end
