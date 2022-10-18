module ExceptionHandler
  def self.included(base)
    base.instance_eval do
      rescue_from :all do |e|
        if e.class.name == "Errors::OAuthUnauthorizedError"
          code = 401
          message = "Unauthorize"
        else
          code = 500
          message = "Internal server error"
        end
        results = {
          code: code,
          messages: message,
        }

        rack_response results.to_json, code
      end
    end
  end
end
