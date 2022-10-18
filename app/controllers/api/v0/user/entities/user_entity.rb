class Api::V0::User::Entities::UserEntity < Grape::Entity
  expose :id
  expose :username
  expose :fullname
  expose :roles_id
  # expose :name
  expose :created_at
  expose :updated_at
end
