require 'rails_helper'

RSpec.describe CountriesHelper::CountryData, type: :helper do
  describe "#countries" do

    # lets add VCR
    # make the call to the api and store the response in a cassette
    # use the cassette to test the helper method

    subject { described_class.new }

    let(:country_code) { nil }
    let(:options) do
      country_code.nil? ? {} : { "code" => country_code.to_s }
    end

    context "when country_code is nil" do
      it "returns all the countries" do
        VCR.use_cassette("api-football/countries/all_countries") do
          expect(subject.countries(options)["response"].size).to be > 2
        end
      end
    end

    context "when country_code is not nil" do
      let(:country_code) { "na" }

      it "returns only the specified country requested" do
        VCR.use_cassette("api-football/countries/na") do
          countries = subject.countries(options)

          number_of_responses = countries["response"].size
          name_of_country = countries["response"][0]["name"]

          expect(number_of_responses).to be == 1
          expect(name_of_country).to eq "Namibia"
        end
      end
    end
  end
end
