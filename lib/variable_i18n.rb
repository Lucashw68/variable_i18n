# frozen_string_literal: true

require_relative "variable_i18n/version"
require "i18n"

# Plugin for rails-i18n gem to handle variables in translations
module VariableI18n
  I18n::Backend::Base.module_eval do
    alias_method :original_translate, :translate

    # ###########################################################
    # Custom translate method
    # ###########################################################

    def translate(locale, key, options = {})
      translation = original_translate(locale, key, options)

      if translation.is_a?(Array) && !translation.frozen?
        translation.each_with_index do |translation_subpart, i|
          translation[i] = replace_variable_in_translation(translation_subpart) if translation_subpart.is_a? String
        end
      elsif translation.is_a?(String) && !translation.frozen?
        translation = replace_variable_in_translation(translation)
      end

      translation
    end

    # ###########################################################
    # Replace variable(s) by her corresponding translation
    # ###########################################################

    def replace_variable_in_translation(translation)
      variables = variables?(translation)

      if variables
        variables.each do |variable|
          key = variable[/@\[(.*?)\]/m, 1]
          options = key.scan(/\{.*?\}/)

          if options.any?
            options = eval(options.first)
            key = key.split(",").first
          else
            options = {}
          end

          translation = translation.sub(variable, I18n.translate(key, **options))
        end
      end

      translation
    end

    private

    # ###########################################################
    # Check if the string contains variables
    # ###########################################################

    def variables?(translation)
      nested_words = translation.scan(/@\[.*?\]/)
      if nested_words.none?
        false
      else
        nested_words
      end
    end
  end
end
