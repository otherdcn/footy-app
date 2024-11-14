module LeaguesHelper
  class LeagueData < ApplicationHelper::APIFootball
    ENDPOINT = "/leagues".freeze

    def leagues(options = {})
      defualt_queries = { "type" => "league", "current" => "true" }
      queries = { query: defualt_queries.merge(options) }

      self.class.get(ENDPOINT, queries)
    end
  end
end
