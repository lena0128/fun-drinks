class Item < ApplicationRecord
    has_many :drinks
    #accepts_nested_attributes_for :drinks

    before_validation :make_title_case
    validates :name, presence: true, uniqueness: true
    validates_presence_of :description, :alcohol
    validate :is_title_case
    
    def drinks_attributes=(drinks_attributes)
        drinks_attributes.values.each do |drink_attribute|
          drink = Drink.find_or_create_by(drink_attribute)
          self.drinks << drink
        end
      end

    def is_title_case
        if self.name != self.name.titlecase
            self.errors.add(:name, "must be titlecase!")
        end
    end

    def make_title_case
        self.name = name.titlecase
    end
end