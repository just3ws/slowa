# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.acronym 'API'
  # inflect.plural /^(ox)$/i, '\1en'
  # inflect.singular /^(ox)en/i, '\1'
  # inflect.uncountable %w( fish sheep )
  inflect.irregular('biscotto', 'biscotti')
  inflect.irregular('cookie', 'cookies')
end
