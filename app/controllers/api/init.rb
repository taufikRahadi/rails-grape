class Api::Init < Grape::API
  prefix 'api'

  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger,
               logger: Logger.new($stderr),
               headers: %w[version cache-control]

  helpers do
    def authenticate!
      header = request.headers['Authorization']
      header = header.split(' ').last if header

      begin
        decoded = Jsonwebtoken.decode(header)

        @current_user = User.find(decoded['user_id'])

      rescue ActiveRecord::RecordNotFound => e
        status 403
        error!(['Forbidden Request', e.message], env['api.response.code'] = 403)
      rescue JWT::DecodeError => e
        error!('Unauthorized', env['api.response.code'] = 401)
      end
    end

    def authorize!(*roles)
      user_role = @current_user.role.name

      error!('Forbidden request', env['api.response.code'] = 403) unless roles.include? user_role
    end
  end

  mount Api::V0::Main
end
