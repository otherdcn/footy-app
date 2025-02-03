module CountriesHelper
  class CountryData < ApplicationHelper::APIFootball
    ENDPOINT = "/countries".freeze

    def countries(options = {})
      #debugger
      queries = { query: options }

      self.class.get(ENDPOINT, queries)
    end
  end
end
