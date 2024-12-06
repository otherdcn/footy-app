require 'rails_helper'

RSpec.describe CountriesHelper, type: :helper do
  describe "#countries" do
    # def get_countries(country_code: nil)
    #   countries_data = CountriesHelper::CountryData.new
    #   options = country_code.nil? ? {} : { "code" => country_code.to_s }

    #   countries_data.countries(options)
    # end

    subject { CountriesHelper::CountryData.new }
    let(:country_code) { nil }
    let(:options) do
      country_code.nil? ? {} : { "code" => country_code.to_s }
    end

    context "when country_code is nil" do
      it "returns all the countries" do
        subject.countries(options)["response"].to be > 2
      end
    end

    context "when country_code is not nil" do
      let(:country_code) { "na" }

      it "returns only the specified country requested" do
        countries = subject.countries(options)

        number_of_responses = countries["response"].size
        name_of_country = countries["response"][0]["name"]

        expect(number_of_responses).to be == 1
        expect(name_of_country).to eq "Namibia"
      end
    end


    # context "when no arguments are given" do

    #   it "returns all the countries" do
    #     countries = get_countries(country_code: nil)

    #     number_of_responses = countries["response"].size

    #     expect(number_of_responses).to be > 2

    #   end

    # end

    # context "when arguments are given" do

    #   it "returns only the specified country requested" do
    #     countries = get_countries(country_code: "na")

    #     number_of_responses = countries["response"].size
    #     name_of_country = countries["response"][0]["name"]

    #     expect(number_of_responses).to be == 1
    #     expect(name_of_country).to eq "Namibia"
    #   end

    # end
  end
end
