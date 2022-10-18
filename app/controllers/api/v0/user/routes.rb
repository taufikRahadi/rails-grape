class Api::V0::User::Routes < Grape::API
  formatter :json, SuccessFormatter
  error_formatter :json, ErrorFormatter

  mount Api::V0::User::Resources::User
end