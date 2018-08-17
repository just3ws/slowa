# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action -> { request.format = :json }
end
