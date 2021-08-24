class DrinksController < ApplicationController

    def index
        @drinks = Drink.all
    end

    def new
        @drink = Drink.new
    end

    def show
        @drink = Drink.find_by(id: params[:id])
    end

    def create
    end

    def edit
        @drink = Drink.find_by(id: params[:id])
    end

    def update
    end

    def destroy
        @drink = Drink.find_by(id: params[:id])
    end

    private
    def drink_params
        params.require(:drink).permit(:drink_name, :drink_thumb, :item_id)
    end

end
