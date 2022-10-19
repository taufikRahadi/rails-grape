class Api::V0::User::Entities::UserEntity < Grape::Entity
  expose :id
  expose :username
  expose :fullname
  expose :role, using: Api::V0::Role::Entities::RoleEntity
  expose :created_at
  expose :updated_at
end
