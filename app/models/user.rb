class User < ApplicationRecord
    has_many :drinks
    has_many :items, through: :drinks

    has_secure_password

    validates :username, presence: true, uniqueness: true, length: { minimum: 2 }
    validates :email, presence: true

    
end