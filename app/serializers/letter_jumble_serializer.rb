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

class LetterJumbleSerializer
  include FastJsonapi::ObjectSerializer

  attributes :letters, :words
end
