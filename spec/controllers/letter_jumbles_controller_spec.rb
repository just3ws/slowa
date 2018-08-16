# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LetterJumblesController, type: :controller do
  let(:letter_jumble) { LetterJumbleSolver.new(letters: 'hello').call.letter_jumble }

  it 'find by letters' do
    get :show, params: { letters: letter_jumble.letters }

    ap response.headers
    ap response.body
  end
end
