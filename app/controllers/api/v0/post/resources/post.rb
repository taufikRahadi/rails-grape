class Api::V0::Post::Resources::Post < Grape::API
  desc 'creates a new post with draft status'
  params do
    requires :title, type: String, length: 3
    requires :body, type: String
    requires :author_id, type: Integer
    optional :status, type: String
  end
  post '/' do
    authenticate!
    
    user_role = @current_user.role.name
    begin
      status = 'draft' if user_role == 'author'
    end
  end
end