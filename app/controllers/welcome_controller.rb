class WelcomeController < ApplicationController
    
    def home
        @item = Item.last
    end
    
end