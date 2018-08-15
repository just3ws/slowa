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

require 'biscotti/letters'

class LetterJumble < ApplicationRecord
  VERSION_DEFAULT = 1

  LETTERS_COUNT_MIN = 2
  LETTERS_COUNT_MAX = 8

  attribute :version, default: -> { VERSION_DEFAULT }

  validates :letters, length: { in: LETTERS_COUNT_MIN..LETTERS_COUNT_MAX },
                      uniqueness: { case_insensitive: false },
                      presence: true
  validates :version, numericality: { only_integer: true, equal_to: VERSION_DEFAULT },
                      presence: true

  before_validation :format_letters

  private

  def format_letters
    self.letters = Biscotti::Letters.format(letters) if letters.present?
  end
end
