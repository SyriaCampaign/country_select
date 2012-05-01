require 'csv'
# CountrySelect
module ActionView
  module Helpers
    module FormOptionsHelper


      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select(object, method, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(options, html_options)
      end
      
      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def country_options_for_select(selected = nil, options = nil)
        country_options = ""
        options ||= {}

        if options[:placeholder]
          country_options += %{<option value="" disabled="">#{options[:placeholder]}</option>}
        end

        if options[:priority_countries]
          separator_string = options[:separator] || PurposeCountrySelect::SEPARATOR_STRING
          country_options += options_for_select(options[:priority_countries], selected)
          country_options += %{<option value="" disabled="">#{separator_string}</option>}
          # prevents selected from being included twice in the HTML which causes
          # some browsers to select the second selected option (not priority)
          # which makes it harder to select an alternative priority country
          selected = nil if options[:priority_countries].include?(selected)
        end

        return_country_options(countries(options), country_options, selected).html_safe
      end

      def countries(options={})
        options[:donation] ? PurposeCountrySelect::DONATION_COUNTRIES : PurposeCountrySelect::COUNTRIES
      end

      def return_country_options(countries, country_options, selected)
        return country_options + options_for_select(countries[I18n.locale.to_s], selected)
      end
    end

    class InstanceTag
      def to_country_select_tag(options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, options),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def country_select(method, options = {}, html_options = {})
        @template.country_select(@object_name, method, options.merge(:object => @object), html_options)
      end
    end
  end
end
