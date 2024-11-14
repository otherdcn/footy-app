class CountriesController < ApplicationController
  include CountriesHelper

  before_action :set_api_football, :set_countries

  def index
    @countries
  end

  private

  def set_api_football
    @api_football_country = CountriesHelper::CountryData.new
  end

  def set_countries
    @countries = @api_football_country.countries["response"]
  end
end
