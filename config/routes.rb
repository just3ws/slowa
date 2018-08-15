# frozen_string_literal: true

# == Route Map
#
#         Prefix Verb URI Pattern                   Controller#Action
# letter_jumbles GET  /letter_jumbles(.:format)     letter_jumbles#index
#                POST /letter_jumbles(.:format)     letter_jumbles#create
#  letter_jumble GET  /letter_jumbles/:id(.:format) letter_jumbles#show

Rails.application.routes.draw do
  resources :letter_jumbles, only: %i[show create index]
end
