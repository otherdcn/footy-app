class CountriesController < ApplicationController
  include CountriesHelper

  before_action :set_countries

  def index
    @countries
  end

  private

  def set_countries
    @countries = get_countries["response"]
  end
end
