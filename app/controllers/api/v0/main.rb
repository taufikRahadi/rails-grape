class Api::V0::Main < Grape::API
  include Config

  version 'v0', using: :path

  mount Api::V0::User::Routes
end