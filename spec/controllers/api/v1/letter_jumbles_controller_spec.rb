# frozen_string_literal: true

require 'rails_helper'

module API
  module V1
    RSpec.describe LetterJumblesController, type: :controller do
      subject { response }

      let(:letters) { 'hello' }

      let(:letter_jumble) { LetterJumbleSolver.new(letters: letters).call.data }
      let(:payload) { JSON.parse(subject.body, symbolize_names: true) }

      describe 'POST #create' do
        before { post(:create, params: { id: letter_jumble.letters }) }

        it 'responds as JSON API' do
          expect(response.content_type).to eq('application/vnd.api+json')
        end

        context 'when receiving a new set of valid letters' do
          it 'responds with status code :ok (200)' do
            is_expected.to have_http_status(:ok)
          end

          it 'responds with formatted letters' do
            expect(payload.dig(:data, :attributes, :letters)).to eq(letters.downcase.split('').sort.join)
          end

          it 'responds with array of words' do
            expect(payload.dig(:data, :attributes, :words)).not_to be_empty
          end
        end

        context 'when receiving an invalid request' do
          let(:letters) { 'thiswordiswaytoolong' }

          it 'responds with status code :not_acceptable (406)' do
            is_expected.to have_http_status(:not_acceptable)
          end

          it 'responds with errors' do
            expect(payload).not_to be_empty
          end
        end
      end

      describe 'GET #index' do
        before { get(:index) }

        it 'responds as JSON API' do
          expect(response.content_type).to eq('application/vnd.api+json')
        end
      end

      describe 'GET #show' do
        before { get(:show, params: { id: letter_jumble.letters }) }

        it 'responds as JSON API' do
          expect(response.content_type).to eq('application/vnd.api+json')
        end

        context 'when receiving an existing set of valid letters' do
          let(:letter_jumble) { LetterJumbleSolver.new(letters: letters).call.data }

          it 'responds with status code :ok (200)' do
            is_expected.to have_http_status(:ok)
          end
        end

        context 'when receiving an non-existent set of valid letters' do
          let(:letter_jumble) { LetterJumble.find_or_initialize_by(letters: Letters.format(letters)) }

          it 'responds with a not_found status code (404)' do
            is_expected.to have_http_status(:not_found)
          end
        end
      end
    end
  end
end
