class Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user, class_name: "user", foreign_key: "user_id"
end
