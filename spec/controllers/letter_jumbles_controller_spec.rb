# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LetterJumblesController, type: :controller do
  subject { response }

  let(:letters) { Faker::Lorem.word.slice(0, 8) }

  describe 'POST #create' do
    let(:letter_jumble) { LetterJumbleSolver.new(letters: letters).call.letter_jumble }

    before { post(:create, params: { letters: letter_jumble.letters }) }

    context 'ok' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'GET #show' do
    before { get(:show, params: { letters: letter_jumble.letters }) }

    context 'ok' do
      let(:letter_jumble) { LetterJumbleSolver.new(letters: letters).call.letter_jumble }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'not_found' do
      let(:letter_jumble) { LetterJumbleFinder.new(letters: letters).call.letter_jumble }

      it { is_expected.to have_http_status(:not_found) }

      it 'responds as JSON API' do
        expect(response.content_type).to eq 'application/vnd.api+json'
      end
    end
  end
end
