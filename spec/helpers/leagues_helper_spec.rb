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

    context "when country_code is nil" do

      it "returns all the leagues" do
        VCR.use_cassette("api-football/leagues/all_leagues") do
          leagues = subject.leagues(options)

          number_of_responses = leagues["response"].size

          expect(number_of_responses).to be > 2
        end
      end

    end

    context "when country_code is not nil" do
      let(:country_code) { "FR" }

      it "returns only the specified country's leagues requested" do
        VCR.use_cassette("api-football/leagues/fr/leagues") do
          leagues = subject.leagues(options)

          number_of_responses = leagues["response"].size
          name_of_country = leagues["response"][0]["name"]

          expect(same_country?(leagues, country_code)).to be true
        end
      end

    end
  end
end
