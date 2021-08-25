class User < ApplicationRecord
    has_many :drinks
    has_many :items, through: :drinks

    has_secure_password

    validates :username, presence: true, uniqueness: true, length: { minimum: 2 }
    validates :email, presence: true

    def self.create_from_omniauth(auth)
        User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.username = auth['info']['first_name']
            u.email = auth['info']['email']
            u.password = SecureRandom.hex(16)
        end
    end
    
end