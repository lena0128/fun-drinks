class DrinksController < ApplicationController
    before_action :set_drink, only: [:show, :destroy]

    def index
        if params[:name]
            @drinks = Drink.drink_search(params[:name])
        else
          @drinks = Drink.all
        end
    end

    def new
        # by checking if there is an item_id in the params hash, we can know which item we are associated with
        if params[:item_id]
            @item = Item.find_by(id: params[:item_id])
            # by calling #build method, the new drink object will authomatically have an associated item_id 
            @drink = @item.drinks.build
        else
            @drink = Drink.new
            @items = Item.all
        end
    end

    def show
    end

    def create
        @drink = Drink.create(drink_params)
        @drink.user = current_user
        if params[:item_id]
            @drink.item_id = params[:item_id]
        end
            @drink.save
            redirect_to drinks_path
    end

    def destroy
        @drink.delete
        redirect_to drinks_path
    end

    private
    def drink_params
        params.require(:drink).permit(:drink_name, :drink_thumb, :item_id)
    end

    def set_drink
        @drink = Drink.find_by(id: params[:id])
    end

end
