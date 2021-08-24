class DrinksController < ApplicationController

    def index
        @drinks = Drink.all
    end

    def new
        @drink = Drink.new
        @items = Item.all
    end

    def show
        @drink = Drink.find_by(id: params[:id])
    end

    def create
        @drink = Drink.new(drink_params)
        if @drink.save
            redirect_to drink_path(@drink)
        else
            render :new
        end
    end

    def edit
        @drink = Drink.find_by(id: params[:id])
    end

    def update
    end

    def destroy
        @drink = Drink.find_by(id: params[:id])
        @drink.delete
        redirect_to drinks_path
    end

    private
    def drink_params
        params.require(:drink).permit(:drink_name, :drink_thumb, :item_id)
    end

end
