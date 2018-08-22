# frozen_string_literal: true

# == Route Map
#
#                Prefix Verb URI Pattern                                Controller#Action
#                       GET  /api/1/letter_jumbles/page/:page(.:format) api/v1/letter_jumbles#index {:format=>"json"}
# api_v1_letter_jumbles GET  /api/1/letter_jumbles(.:format)            api/v1/letter_jumbles#index {:format=>"json"}
#                       POST /api/1/letter_jumbles(.:format)            api/v1/letter_jumbles#create {:format=>"json"}
#  api_v1_letter_jumble GET  /api/1/letter_jumbles/:id(.:format)        api/v1/letter_jumbles#show {:format=>"json"}

Rails.application.routes.draw do
  namespace(:api, constraints: { format: 'json' }) do
    namespace(:v1, path: '/1') do
      resources(:letter_jumbles, only: %i[create index show]) do
        get('page/:page', action: :index, on: :collection)
      end
    end
  end
end
