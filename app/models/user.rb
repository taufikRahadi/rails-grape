class User < ApplicationRecord
  has_many :posts
  belongs_to :role, class_name: "Role", foreign_key: "roles_id"

  before_save :hash_password

  validates :username, presence: true, uniqueness: { message: 'User already exists' }

  private
    def hash_password
      self.password = BCrypt::Password.create(self.password)
    end
end
