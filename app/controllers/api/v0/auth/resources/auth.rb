class Api::V0::Auth::Resources::Auth < Grape::API
  resources :auth do
    
    desc "login user"
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post "/" do
      username = params[:username]
      password = params[:password]

      user = User.find_by(username: username)
      validate_password = user.authenticate(password)
      error!('Wrong Password', env['api.response.code'] = 422) unless validate_password

      token = Jsonwebtoken.encode(user_id: user[:id])

      status 200
      present :auth, token
    end
  end
end
