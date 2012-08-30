require 'purpose_country_select'

describe "CountryHelper" do
  include CountryHelper

  it "should provide country names in specified locales" do
    country_name("us", "en").should == "United States"
    country_name("us", "pt").should == "EUA"
    country_name("us", "es").should == "Estados Unidos"
  end

  it "should allow iso_code as symbols" do
    country_name(:us, "en").should == "United States"
  end

  it "should allow locales as symbols" do
    country_name("us", :en).should == "United States"
  end

  it "should use the default locale when the specified locale is unknown" do
    country_name("us", :zz).should == "United States"
  end

  it "should return the specified country iso when there is no matching country" do
    country_name("invalid_iso_code", "en").should == "invalid_iso_code"
  end
end