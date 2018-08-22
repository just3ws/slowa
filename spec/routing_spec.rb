# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it { is_expected.to route(:get, '/api/1/letter_jumbles').to(controller: 'api/v1/letter_jumbles', action: :index) }
  it { is_expected.to route(:get, '/api/1/letter_jumbles/hello').to(controller: 'api/v1/letter_jumbles', action: :show, id: 'hello') }
  it { is_expected.to route(:post, '/api/1/letter_jumbles').to(controller: 'api/v1/letter_jumbles', action: :create) }
end
