module ApplicationHelper
  class APIFootball
    include HTTParty
    API_KEY = Rails.application.credentials.api_sports.football[:key]
    base_uri  "https://v3.football.api-sports.io/"
    headers   "x-apisports-key" => API_KEY
  end
end
