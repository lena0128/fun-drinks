class Item < ApplicationRecord
    has_many :drinks
    has_many :users, through: :drinks
    # accepts_nested_attributes_for :drinks

    before_validation :make_title_case
    validates :name, presence: true, uniqueness: true
    validates :alcohol, presence: true, inclusion: { in: %w(yes no), message: "must be yes or no" }
    validates :description, presence: true, length: { minimum: 5 }
    validate :is_title_case

    scope :item_search, ->(name) { where("name LIKE ?", "%#{name.titlecase}%") } 
    scope :filter_alcohol, -> { where(alcohol: "yes").last(3) } 
    scope :filter_non_alcohol, -> { where(alcohol: "no").last(3) }

    
    def drinks_attributes=(drinks_attributes)
        drinks_attributes.values.each do |hash|
            if hash[:id]
                drink = Drink.find_by(id: hash[:id])
                drink.update(hash)
            else
          drink = Drink.find_or_create_by(hash)
          self.drinks << drink
        end
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