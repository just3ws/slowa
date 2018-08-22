# frozen_string_literal: true

require 'rails_helper'

module API
  module V1
    RSpec.describe LetterJumblesController, type: :controller do
      subject { response }

      let(:letters) { Faker::Lorem.word.slice(0, 8) }
      let(:letter_jumble) { LetterJumbleSolver.new(letters: letters).call.letter_jumble }
      let(:payload) { JSON.parse(subject.body, symbolize_names: true) }

      describe 'POST #create' do
        before { post(:create, params: { id: letter_jumble.letters }) }

        context 'ok' do
          it { is_expected.to have_http_status(:ok) }

          it 'has letters' do
            expect(payload.dig(:data, :attributes, :letters)).to eq(letters.downcase.split('').sort.join)
          end

          it 'has words' do
            expect(payload.dig(:data, :attributes, :words)).not_to be_empty
          end
        end

        context 'not_acceptable' do
          let(:letters) { 'thiswordiswaytoolong' }

          it { is_expected.to have_http_status(:not_acceptable) }

          it 'has errors' do
            expect(payload).not_to be_empty
          end
        end
      end

      describe 'GET #show' do
        before { get(:show, params: { id: letter_jumble.letters }) }

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
  end
end
