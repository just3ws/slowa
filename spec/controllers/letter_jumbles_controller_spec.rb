# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LetterJumblesController, type: :controller do
  it do
    get letter_jumbles_path(id: 1)
  end
end
