class Api::V0::User::Resources::User < Grape::API
  resources :user do
    desc 'Get list of users'
    get '/' do
      data = User.all

      present :user, data, with: Api::V0::User::Entities::UserEntity
    end

    desc 'Create new user and return created user'
    post '/' do
      user = User.create(
        fullname: params[:fullname],
        username: params[:username],
        password: params[:password],
        roles_id: params[:roles_id]
      )

      error!('Failed creating user', env['api.response.code'] = 422) unless user.id
      present :user, user, with: Api::V0::User::Entities::UserEntity
    end

    desc 'Retrieve user by id'
    get '/:id' do
      data = User.joins(:role).select('*').where(id:params[:id]).first()

      error!('User not found', env['api.response.code'] = 422) unless data.present?

      present :user, data, with: Api::V0::User::Entities::UsersEntity
    end
  end
end
