class CountriesController < ApplicationController
  include CountriesHelper

  before_action :set_api_football, :set_countries

  def index
    @countries
  end

  private

  def set_api_football
    @api_football = CountriesHelper::APIFootball.new
  end

  def set_countries
    @countries = @api_football.countries["response"]
  end
end
