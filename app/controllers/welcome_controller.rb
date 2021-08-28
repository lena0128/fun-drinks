class WelcomeController < ApplicationController
    
    def home
        @alc_drinks = Drink.alcohol_drink_filter
        @non_alc_drinks = Drink.non_alcohol_drink_filter
        @alc_items = Item.filter_alcohol
        @non_alc_items = Item.filter_non_alcohol
    end
    
end