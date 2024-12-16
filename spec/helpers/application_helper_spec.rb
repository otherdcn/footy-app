require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context "when checking status" do
    it "returns the account name" do
      VCR.use_cassette("api-football/status_check") do
        api_key = Rails.application.credentials.api_sports.football[:key]
        api_football_status_url = "https://v3.football.api-sports.io/status"

        response = ApplicationHelper::APIFootball.get(api_football_status_url,
                                                      headers: { "x-apisports-key" => api_key }
                                                     )

        account_name = response["response"]["account"]["firstname"] + response["response"]["account"]["lastname"]

        expect(account_name).to eq "DCN"
      end
    end
  end
end
