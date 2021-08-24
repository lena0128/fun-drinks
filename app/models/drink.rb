class Drink < ApplicationRecord
    belongs_to :item
    
    validates :drink_name, presence: true, uniqueness: true
    
end
