# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  describe '/letter_jumbles' do
    it { is_expected.to route(:get, '/letter_jumbles').to(controller: :letter_jumbles, action: :index) }
    it { is_expected.to route(:get, '/letter_jumbles/hello').to(controller: :letter_jumbles, action: :show, letters: 'hello') }
    it { is_expected.to route(:post, '/letter_jumbles').to(controller: :letter_jumbles, action: :create) }
  end
end
