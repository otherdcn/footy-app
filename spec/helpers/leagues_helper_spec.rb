require 'rails_helper'

RSpec.describe LeaguesHelper::LeagueData, type: :helper do
  describe "#countries" do

    def same_country?(response_hash, country_code)
      country_code_list = []

      response_hash["response"].each do |league|
        country_code_list << league["country"]["code"]
      end

      country_code_list.all? { |element| element == country_code }
    end

    subject { described_class.new }

    let(:country_code) { nil }
    let(:options) do
      country_code.nil? ? {} : { "code" => country_code.to_s }
    end

    it "returns an array object as a response" do
      VCR.use_cassette("api-football/all_countries/all_leagues") do
        expect(subject.leagues(options)["response"]).to be_kind_of(Array)
      end
    end

    context "when country_code is nil" do

      it "returns all the leagues" do
        VCR.use_cassette("api-football/leagues/all_leagues") do
          leagues = subject.leagues(options)

          expect(same_country?(leagues, country_code)).to be false
        end
      end

    end

    context "when country_code is not nil" do
      let(:country_code) { "FR" }

      it "returns only the specified country's leagues requested" do
        VCR.use_cassette("api-football/leagues/fr/leagues") do
          leagues = subject.leagues(options)

          expect(same_country?(leagues, country_code)).to be true
        end
      end

    end

    context "when country code is not nil but is unknown/invalid" do
      let(:country_code) { "FRA" }

      it "returns an empty response" do
        VCR.use_cassette("api-football/leagues/fra/leagues") do
          leagues = subject.leagues(options)

          response_data = leagues["response"]

          expect(response_data).to be_empty
        end
      end

      it "returns with no errors" do
        VCR.use_cassette("api-football/leagues/fra/leagues") do
          leagues = subject.leagues(options)

          response_errors = leagues["errors"]

          expect(response_errors).to be_empty
        end
      end
    end
  end
end
