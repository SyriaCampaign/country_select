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

  it "should render a placeholder if one is given" do
    CountrySelectHelper.new.country_select("foo", "country", :placeholder => "Select Country").should have_tag("select") do
      with_tag 'option[disabled]', "Select Country"
    end
  end

  it "should add the priority countries to the top of the options list" do
    CountrySelectHelper.new.country_select("foo", "country", :priority_countries => ['us', 'br']).should have_tag("select") do
      with_tag 'option:nth-child(1)', "us"
      with_tag 'option:nth-child(2)', "br"
      with_tag 'option:nth-child(3)', PurposeCountrySelect::SEPARATOR_STRING
    end
  end

  it "should select the first option when no selected value is specified" do
    CountrySelectHelper.new.country_select("foo", "country", :priority_countries => ['us', 'br']).should have_tag("select") do
      with_tag 'option[selected]', "us"
    end
  end
end
