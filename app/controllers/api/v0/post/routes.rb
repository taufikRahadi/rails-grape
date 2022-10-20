class Api::V0::Post::Routes < Grape::API
  error_formatter :json, ErrorFormatter

  mount Api::V0::Post::Resources::Post
end