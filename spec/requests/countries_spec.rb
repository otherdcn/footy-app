require 'rails_helper'

RSpec.describe "Countries API requests", type: :request do
  describe "#index" do
    it 'returns a list of footballing countries' do
      VCR.use_cassette("api-football/countries/all_countries") do
        get "/"

        expect(response).to have_http_status(:ok)

        expect(response).to render_template(:index)
        expect(response.body).to include("Footballing Countries")
        expect(response.body).to include("Check one of the")
      end
    end
  end

  describe "#show" do
    it "returns a list of all leagues from a specific country" do
      VCR.use_cassette("api-football/countries/112/all_leagues") do
        country_id = "112"

        get "/countries/#{country_id}", :params => { "id" => country_id }

        expect(response).to have_http_status(:ok)

        expect(response).to render_template(:show)
        expect(response.body).to include("Namibia | NA")
      end
    end
  end
end

