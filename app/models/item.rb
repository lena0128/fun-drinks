class Item < ApplicationRecord
    has_many :drinks

    before_validation :make_title_case
    validates :name, presence: true, uniqueness: true
    validates_presence_of :description, :alcohol
    validate :is_title_case
    

    def is_title_case
        if self.name != self.name.titlecase
            self.errors.add(:name, "must be titlecase!")
        end
    end

    def make_title_case
        self.name = name.titlecase
    end
end