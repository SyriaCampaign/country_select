require 'purpose_country_select'
require 'rspec-html-matchers'

describe "CountrySelect Initializer" do
  it "should build the list of countries associated by the country iso code" do
    PurposeCountrySelect::COUNTRIES['iso'].should include("br")
    PurposeCountrySelect::COUNTRIES['en'].should include(["Brazil", "br"])
    PurposeCountrySelect::COUNTRIES['pt'].should include(["Brasil", "br"])
  end

  class CountrySelectHelper
    include ActionView::Helpers::FormOptionsHelper
  end

  it "should render the select html tag containing all languages" do
    CountrySelectHelper.new.country_select("foo", "country").should have_tag('select[name="foo[country]"]') do
      with_tag 'option[value="br"]', "Brazil"
    end
  end
end
