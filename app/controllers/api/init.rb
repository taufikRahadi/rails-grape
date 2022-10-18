class Api::Init < Grape::API
  prefix 'api'

  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger,
               logger: Logger.new($stderr),
               headers: %w[version cache-control]

  mount Api::V0::Main
end
