module Helpers
  class JsonHelper
    def self.json_params(params)
      begin
        JSON.parse(params)
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end
  end
end
