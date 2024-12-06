require 'rails_helper'

RSpec.describe "Countries API requests", type: :request do
  describe "#index" do

    let(:countries_helper) { double(CountriesHelper::CountryData) }
    before do
      allow(CountriesHelper::CountryData).to receive(:new).and_return(countries_helper)
      allow(countries_helper).to receive(:countries).and_return({ "response" => [{ "name" => "Namibia", "code" => "NA" }] })
    end

    it "returns a list of all footballing countries" do
      get "/"

      expect(response).to have_http_status(:ok)

      expect(response).to render_template(:index)
      expect(response.body).to include("Footballing Countries")
      expect(response.body).to include("Check one of the")
    end
  end

  describe "#show" do
    it "returns a list of all leagues from a specific country" do
      country_id = "112"

      get "/countries/#{country_id}", :params => { "id" => country_id }

      expect(response).to have_http_status(:ok)

      expect(response).to render_template(:show)
      expect(response.body).to include("Namibia | NA")
    end
  end
end
