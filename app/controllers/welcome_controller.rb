class WelcomeController < ApplicationController
    
    def home
        @alc_drinks = Drink.alcohol_drink_filter
        @non_alc_drinks = Drink.non_alcohol_drink_filter
    end
    
end