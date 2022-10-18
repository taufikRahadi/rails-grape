class Api::Init < Grape::API
  # insert_after Grape::Middleware::Formatter, headers: %w[version cache-control]

  prefix "api"
  mount Api::V0::Main
end
