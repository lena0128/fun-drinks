class ItemsController < ApplicationController

    def index
        @items = Item.all
    end

    def show
        @item = Item.find_by(id: params[:id])
    end

    def new
        @item = Item.new
        @item.drinks.build
    end
    
    def create
        @item = Item.new(item_params)
        if @item.save
            binding.pry
          redirect_to item_path(@item)
        else
          render :new
        end
    end

    def edit
        @item = Item.find_by(id: params[:id])
    end

    def update
        @item = Item.find_by(id: params[:id])
        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            render :edit
        end
    end

    def destroy
        @item = Item.find_by(id: params[:id])
        @item.delete
        redirect_to items_path
    end

    private

      def item_params
          params.require(:item).permit(
              :name,
              :image_url,
              :description,
              :alcohol, 
              drinks_attributes: [:drink_name, :drink_thumb]
          )
      end

end