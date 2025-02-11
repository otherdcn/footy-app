require 'rails_helper'

RSpec.describe CountriesHelper::CountryData, type: :helper do
  describe "#countries" do
    subject { described_class.new }

    let(:country_code) { nil }
    let(:options) do
      country_code.nil? ? {} : { "code" => country_code.to_s }
    end

    it "returns an array object as a response" do
      VCR.use_cassette("api-football/countries/all_countries") do
        expect(subject.countries(options)["response"]).to be_kind_of(Array)
      end
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

    context "when country_code is not nil but is unknown/invalid" do
      let(:country_code) { "nam" }

      it "returns an empty response" do
        VCR.use_cassette("api-football/countries/nam") do
          countries = subject.countries(options)

          response_data = countries["response"]

          expect(response_data).to be_empty
        end
      end

      it "returns with no errors" do
        VCR.use_cassette("api-football/countries/nam") do
          countries = subject.countries(options)

          response_errors = countries["errors"]

          expect(response_errors).to be_empty
        end
      end
    end
  end
end
