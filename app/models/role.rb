class Role < ApplicationRecord
  has_many :users, class_name: "User", foreign_key: "roles_id"
end
