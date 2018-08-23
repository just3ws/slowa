# frozen_string_literal: true

# == Schema Information
#
# Table name: letter_jumbles
#
#  id         :bigint(8)        not null, primary key
#  letters    :string           not null
#  words      :string           default([]), is an Array
#  version    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe LetterJumble, type: :model do
  subject(:letter_jumble) { described_class.create(letters: 'example') }

  describe 'validations' do
    it do
      is_expected.to validate_length_of(:letters)
        .is_at_least(LetterJumble::LETTERS_COUNT_MIN)
        .is_at_most(LetterJumble::LETTERS_COUNT_MAX)
    end

    it { is_expected.to validate_presence_of(:version) }
    it { is_expected.to validate_numericality_of(:version) }
    it { is_expected.to validate_numericality_of(:version).is_equal_to(LetterJumble::VERSION_DEFAULT) }
    it { is_expected.to validate_presence_of(:letters) }
    it { is_expected.to validate_uniqueness_of(:letters).case_insensitive }
  end

  it 'saves the letters formatted' do
    expect(letter_jumble.letters).to eq('aeelmpx')
  end

  describe '#with_letters_formatted' do
    before { letter_jumble }

    it 'finds the matching letters regardless of input order' do
      expect(described_class.with_letters_formatted('xlampee').first).to have_attributes(letters: 'aeelmpx')
    end
  end
end
