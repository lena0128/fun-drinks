class Item < ApplicationRecord
    has_many :drinks

    validates :name, presence: true, uniqueness: true
    validates_presence_of :description, :alcohol

    
end