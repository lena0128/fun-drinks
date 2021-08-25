class Drink < ApplicationRecord
    belongs_to :item
    belongs_to :user
    
    before_validation :make_title_case
    validates :drink_name, presence: true, uniqueness: true
    validates :drink_thumb, presence: true
    validate :is_title_case
    
    scope :drink_search, ->(name) { where("drink_name LIKE ?", "%#{name.titlecase}%") }

    def make_title_case
        self.drink_name = drink_name.titlecase
    end

    def is_title_case
        if self.drink_name != drink_name.titlecase
            self.errors.add(:drink_name, "must be titlecase!")
        end
    end

end
