module ControllerSpecHelper
  module Routes
    def api_host
      "http://localhost:3000/"
    end
  end

  module Actions
    def api_params(options = {})
      {version: "1", format: "json"}.merge(options)
    end

    def json_response(data)
      JSON.parse(data).with_indifferent_access[:response]
    end

    def json_pagination(data)
      JSON.parse(data).with_indifferent_access[:pagination]
    end
  end
end

RSpec.configure do |config|

end
