class Drink < ApplicationRecord
    belongs_to :item
    belongs_to :user
    
    before_validation :make_title_case
    validates :drink_name, presence: true, uniqueness: true
    validates_presence_of :drink_thumb, :recipe
    validate :is_title_case
    
    scope :drink_search, ->(name) { where("drink_name LIKE ?", "%#{name.titlecase}%") }
    scope :alcohol_drink_filter, -> { Drink.joins(:item). where(item: {alcohol: "yes"}).last(3) }
    scope :non_alcohol_drink_filter, -> { Drink.joins(:item). where(item: {alcohol: "no"}).last(3) }

    def make_title_case
        self.drink_name = drink_name.titlecase
    end

    def is_title_case
        if self.drink_name != drink_name.titlecase
            self.errors.add(:drink_name, "must be titlecase!")
        end
    end


end
