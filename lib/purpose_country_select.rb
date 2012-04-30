require 'action_view'

require 'purpose_country_select/purpose_country_select'
require 'purpose_country_select/version'

module PurposeCountrySelect
  COUNTRIES = {}
  DONATION_COUNTRIES = {}

  CSV_HEADERS = ['iso','en','es','pt','fr']
  LANGUAGES = CSV_HEADERS - ['iso']

  DATA_DIR = Pathname.new(__FILE__).join("..", "..", "data")

  class << self
    def init
      CSV_HEADERS.each do |header|
        PurposeCountrySelect::COUNTRIES[header] = ['']
        PurposeCountrySelect::DONATION_COUNTRIES[header] = ['']
      end

      build_countries_hash_from_csv('countries.csv', PurposeCountrySelect::COUNTRIES, CSV_HEADERS)
      build_countries_hash_from_csv('donation_countries.csv', PurposeCountrySelect::DONATION_COUNTRIES, CSV_HEADERS)

      associate_country_iso_codes_with_international_names(PurposeCountrySelect::COUNTRIES, CSV_HEADERS)
      associate_country_iso_codes_with_international_names(PurposeCountrySelect::DONATION_COUNTRIES, CSV_HEADERS)
    end

    private

    def build_countries_hash_from_csv(filename, countries, csv_headers)
      CSV.foreach(DATA_DIR.join(filename), :headers => true, :encoding => "UTF-8") do |row|
        CSV_HEADERS.each do |header|
          countries[header] << row[header]
        end
      end
    end

    def associate_country_iso_codes_with_international_names(csv_rows, csv_headers)
      LANGUAGES.each do |lang|
        csv_rows[lang] = csv_rows[lang].zip(csv_rows['iso'])
      end
    end
  end
end

PurposeCountrySelect.init