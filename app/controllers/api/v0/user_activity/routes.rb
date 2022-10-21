class Api::V0::UserActivity::Routes < Grape::API
  formatter :json, SuccessFormatter
  error_formatter :json, ErrorFormatter

  mount Api::V0::UserActivity::Resources::UserActivity
end
