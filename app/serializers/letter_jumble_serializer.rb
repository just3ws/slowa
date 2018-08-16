# frozen_string_literal: true

class LetterJumbleSerializer
  include FastJsonapi::ObjectSerializer

  attributes :letters, :words
end
