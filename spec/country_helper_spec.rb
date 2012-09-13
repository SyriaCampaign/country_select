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

  it "should tell if a country uses post code or not" do
    is_non_post_code_country("br").should be_false
    is_non_post_code_country(:br).should be_false
    is_non_post_code_country("BR").should be_false
    is_non_post_code_country("Br").should be_false
    is_non_post_code_country("bR").should be_false

    is_non_post_code_country("al").should be_true
    is_non_post_code_country(:al).should be_true
    is_non_post_code_country("AL").should be_true
    is_non_post_code_country("Al").should be_true
    is_non_post_code_country("aL").should be_true

    is_non_post_code_country("").should be_false
    is_non_post_code_country(nil).should be_false
  end
end