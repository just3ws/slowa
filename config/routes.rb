# frozen_string_literal: true

# == Route Map
#
#  Prefix Verb URI Pattern            Controller#Action
# cookies GET  /cookies(.:format)     cookies#index
#         POST /cookies(.:format)     cookies#create
#  cookie GET  /cookies/:id(.:format) cookies#show

Rails.application.routes.draw do
  resources :cookies, only: %i[show create index]
end
