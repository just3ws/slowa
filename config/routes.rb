# frozen_string_literal: true

# == Route Map
#
#         Prefix Verb URI Pattern                        Controller#Action
# letter_jumbles GET  /letter_jumbles(.:format)          letter_jumbles#index {:format=>"json"}
#                POST /letter_jumbles(.:format)          letter_jumbles#create {:format=>"json"}
#                GET  /letter_jumbles/:letters(.:format) letter_jumbles#show {:format=>"json"}

Rails.application.routes.draw do
  resources(:letter_jumbles, only: %i[create index], constraints: { format: 'json' })
  get('/letter_jumbles/:letters' => 'letter_jumbles#show', constraints: { format: 'json' })
end
