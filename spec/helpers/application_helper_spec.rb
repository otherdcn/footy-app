require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context "when checking status" do
    def check_api_football_status
      api_key = Rails.application.credentials.api_sports.football[:key]
      api_football_status_url = "https://v3.football.api-sports.io/status"

      ApplicationHelper::APIFootball.get(api_football_status_url, headers: { "x-apisports-key" => api_key })
    end

    it "returns the account name" do
      response = check_api_football_status 

      account_name = response["response"]["account"]["firstname"] + response["response"]["account"]["lastname"]

      expect(account_name).to eq "DCN"
    end
  end
end
