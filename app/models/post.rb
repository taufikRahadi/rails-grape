class Post < ApplicationRecord
  mount_uploader :cover, PostCoverUploader
  
  has_and_belongs_to_many :tags
  belongs_to :author, class_name: "User", foreign_key: :author_id
end
