# frozen_string_literal: true

class LetterJumblesController < ApplicationController
  def create; end

  def show
    ap show_params
  end

  protected

  def show_params
    params.permit(:id)
  end
end
