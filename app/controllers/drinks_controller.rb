class DrinksController < ApplicationController
    before_action :set_drink, only: [:show, :edit, :update, :destroy]
    before_action :require_login
    before_action :require_creator, only: [:edit, :update, :destroy]

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
            @items = Item.all
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
            if @drink.save
            flash[:message] = "Your drink has been successfully created!"
            redirect_to drink_path(@drink)
        else
            @items = Item.all
            render :new
        end
    end

    def edit
    end

    def update
         if @drink.update(drink_params)
            flash[:message] = "Your drink has been successfully updated!"
            redirect_to drink_path(@drink)
         else
            render :edit
         end
    end

    def destroy
        @drink.delete
        flash[:message] = "You have successfully deleted the drink!"
        redirect_to drinks_path
    end

    private
    def drink_params
        params.require(:drink).permit(:drink_name, :drink_thumb, :recipe, :item_id)
    end

    def set_drink
        @drink = Drink.find_by(id: params[:id])
    end

    def require_creator
        if current_user.id != @drink.user_id
            flash[:message] = "You are not allowed to do this!"
            redirect_to drinks_path
        end
    end

end
