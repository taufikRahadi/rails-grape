class Api::V0::Post::Entities::Post < Grape::Entity
  expose :id
  expose :title
  expose :body
  expose :author, using: Api::V0::User::Entities::UserEntity
  expose :cover, using: Api::V0::Post::Entities::Cover
  expose :status
end
