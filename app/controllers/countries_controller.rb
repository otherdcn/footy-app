class CountriesController < ApplicationController
  include CountriesHelper

  before_action :set_api_football, :set_countries

  def index
    @countries
  end

  def show
    @country = @countries[params["id"].to_i]
    @leagues = LeaguesHelper::LeagueData.new.leagues({code: @country["code"]})["response"]
  end

  private

  def set_api_football
    @api_football_country = Helpers::Countries.new
  end

  def set_countries
    @countries = @api_football_country.countries["response"]
  end
end
