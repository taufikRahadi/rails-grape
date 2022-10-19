class Api::V0::User::Resources::User < Grape::API
  require_relative '../../../../../lib/validations/length'
  require_relative '../../../../../lib/validations/is_unique'

  resources :user do
    desc 'Get list of users'
    get '/' do
      ActivityLog.write(nil, request.ip, 'Get list of users', request.user_agent)
      data = User.all

      present :user, data, with: Api::V0::User::Entities::UserEntity
    end

    desc 'register new user and return created user'
    params do
      requires :fullname, type: String, length: 3
      requires :username, type: String, length: 3, is_unique: [User, 'username']
      requires :password, type: String, length: 8
    end
    post '/register' do
      # begin
      #   user = User.create!()

      present :user, 'anjay'
    end

    desc 'Create new user and return created user'
    post '/' do
      begin
        user = User.create!(
          fullname: params[:fullname],
          username: params[:username],
          password: params[:password],
          roles_id: params[:roles_id]
        )
        status 201
        present :user, user, with: Api::V0::User::Entities::UserEntity

      rescue ActiveRecord::InvalidForeignKey => e
        error!(e.message, env['api.response.code'] = 422)
      rescue ActiveRecord::RecordInvalid => e
        error!(e.message, env['api.response.code'] = 422)
      end
    end

    desc 'Retrieve user by id'
    get '/:id' do
      data = User.joins(:role).select('*').where(id:params[:id]).first()

      error!('User not found', env['api.response.code'] = 422) unless data.present?

      present :user, data, with: Api::V0::User::Entities::UsersEntity
    end
  end
end
