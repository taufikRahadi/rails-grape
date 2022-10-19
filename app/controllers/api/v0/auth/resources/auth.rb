class Api::V0::Auth::Resources::Auth < Grape::API
  require_relative '../../../../../lib/validations/length'
  resources :auth do
    
    desc "login user"
    params do
      requires :username, type: String, length: 3
      requires :password, type: String, length: 8
    end
    post "/" do
      begin
        ActivityLog.write(nil, request.ip, 'new login', request.user_agent)

        username = params[:username]
        password = params[:password]

        user = User.find_by!(username: username)
        validate_password = user.authenticate(password)
        error!('Wrong Password', env['api.response.code'] = 422) unless validate_password

        token = Jsonwebtoken.encode(user_id: user[:id])

        status 200
        present :auth, token
      rescue ActiveRecord::RecordNotFound
        error!("couldnt find user with username #{params[:username]}", 422)
      end
    end
  end
end
