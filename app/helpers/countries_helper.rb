require "json"
module CountriesHelper
  def get_countries
    require "uri"
    require "net/http"

    url = URI("https://v3.football.api-sports.io/countries")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    #request["x-rapidapi-host"] = "v3.football.api-sports.io"
    request["x-apisports-key"] = Rails.application.credentials.api_sports[:football][:key]

    response = https.request(request)
    JSON.parse(response.read_body)
  end
end
