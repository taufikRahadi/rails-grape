class Role < ApplicationRecord
  has_many :users, class_name: "User"
end
