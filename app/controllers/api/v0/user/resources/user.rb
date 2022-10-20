class Api::V0::User::Resources::User < Grape::API
  require 'erb'

  resources :user do
    desc 'fetch authenticated user profile'
    get '/profile' do
      authenticate!
      ActivityLog.write(@current_user[:id], request.ip, 'fetch profile', request.user_agent)

      present @current_user, with: Api::V0::User::Entities::UserEntity
    end

    desc 'Get list of users'
    get '/' do
      authenticate!
      authorize!('owner', 'editor')

      ActivityLog.write(@current_user[:id], request.ip, 'Get list of users', request.user_agent)
      data = User.all

      present data, with: Api::V0::User::Entities::UserEntity
    end

    desc 'register new user and return created user'
    params do
      requires :fullname, type: String, length: 3
      requires :username, type: String, length: 3, is_unique: [User, 'username']
      requires :password, type: String, length: 8
    end
    post '/register' do
      begin
        ActivityLog.write(nil, request.ip, 'Registration', request.user_agent)

        user = User.create!(fullname: params[:fullname], username: params[:username], password: params[:password], roles_id: Role.find_by(name: 'user')[:id])

        UserEmailMailer.with(user: user).welcome_email.deliver_later(wait_until: 1.minute)
        present :user, user, with: Api::V0::User::Entities::UserEntity
      rescue Exception => e
        error!(e.message, env['api.response.code'] = 500)
      end
    end

    desc 'Create new user and return created user'
    post '/' do
      begin
        authenticate!

        ActivityLog.write(nil, request.ip, 'create new user', request.user_agent)
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

    desc 'Export user data to pdf'
    get '/pdf' do
      user = User.all

      save_path = Rails.root.join('pdfs', 'filename.pdf')
      
      binding_copy = binding
      template = File.open(Rails.root.join('app/views/layouts/pdf.html.erb'))
      string = ERB.new(template).result(binding_copy)
      pdf = WickedPdf.new.pdf_from_string(string)

      pdf
    end

    desc 'Retrieve user by id'
    get '/:id' do
      begin
        authenticate!

        ActivityLog.write(@current_user[:id], request.ip, 'retrieve user by id', request.user_agent)
        id = params[:id].to_i
        data = User.find(id)

        present data, with: Api::V0::User::Entities::UserEntity
      rescue ActiveRecord::RecordNotFound
        error!('User not found', env['api.response.code'] = 422)
      end
    end
  end
end
