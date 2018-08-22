# frozen_string_literal: true

module API
  module V1
    class LetterJumblesController < ApplicationController
      def index
        collection = paginate(LetterJumble.all)

        options = json_api_pagination_for(collection)

        render(json: LetterJumbleSerializer.new(collection, options))
        # paginate(json: collection)
      end

      def show
        letter_jumble = LetterJumbleFinder.new(letters: letters).call.data

        head(:not_found) && return unless letter_jumble.persisted?

        render(json: LetterJumbleSerializer.new(letter_jumble)) && return if letter_jumble.valid?
      end

      def create
        letter_jumble = LetterJumbleSolver.new(letters: letters).call.data

        render(status: :not_acceptable, json: json_api_errors_for(letter_jumble)) && return if letter_jumble.invalid?

        render json: LetterJumbleSerializer.new(letter_jumble)
      end

      protected

      def json_api_pagination_for(collection)
        # collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)

        current = collection.current_page
        total = collection.total_pages

        {
          meta: {
            total: collection.total_count
          },
          is_collection: true,
          links: {
            first: api_v1_letter_jumbles_url,
            last: api_v1_letter_jumbles_url(page: total),
            self: api_v1_letter_jumbles_url(page: current),
            prev: api_v1_letter_jumbles_url(page: (current > 1 ? (current - 1) : nil)),
            next: api_v1_letter_jumbles_url(page: (current == total ? nil : (current + 1)))
          }
        }
      end

      def letters
        @letters ||= params.require(:id)
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
  end
end
