class Api::V0::Post::Resources::Post < Grape::API
  resources :post do
    desc 'creates a new post with draft status'
    params do
      requires :title, type: String, length: 3
      requires :body, type: String
      optional :status, type: String
      requires :cover, type: File
    end
    post '/' do
      authenticate!
      authorize!('owner', 'author', 'editor')
      
      user_role = @current_user.role.name
      begin
        status = user_role == 'author' ? 'draft' : params[:status]

        post = Post.create!(title: params[:title], body: params[:body], author_id: 21, status: status, cover: params[:cover])

        present Post.find(post[:id]), with: Api::V0::Post::Entities::Post
      rescue ActiveRecord::RecordInvalid => e
        error!(e.message, env['api.response.code'] = 422)
      end
    end

    desc 'retrieve list of posts'
    get '/' do
      authenticate!

      begin
        posts = Post.where.not(status: 'draft')

        present posts, with: Api::V0::Post::Entities::Post
      end
    end
  end
end