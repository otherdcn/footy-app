require 'rails_helper'

RSpec.describe LeaguesHelper, type: :helper do
  describe "#countries" do
    def get_leagues(country_code: nil)
      leagues_data = LeaguesHelper::LeagueData.new
      options = country_code.nil? ? {} : { "code" => country_code.to_s }

      leagues_data.leagues(options)
    end

    def same_country?(response_hash, country_code)
      country_code_list = []

      response_hash["response"].each do |league|
        country_code_list << league["country"]["code"]
      end

      country_code_list.all? { |element| element == country_code }
    end

    context "when no arguments are given" do

      it "returns all the leagues" do
        leagues = get_leagues(country_code: nil)

        number_of_responses = leagues["response"].size

        expect(number_of_responses).to be > 2
      end

    end

    context "when arguments are given" do

      it "returns only the specified country's leagues requested" do
        country_code = "FR"
        leagues = get_leagues(country_code: country_code)

        number_of_responses = leagues["response"].size
        name_of_country = leagues["response"][0]["name"]

        expect(same_country?(leagues, country_code)).to be true
      end

    end
  end
end
