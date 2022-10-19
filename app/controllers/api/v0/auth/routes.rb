class Api::V0::Auth::Routes < Grape::API
  # formatter :json, SuccessFormatter
  error_formatter :json, ErrorFormatter

  mount Api::V0::Auth::Resources::Auth
end
