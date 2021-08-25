class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    def index
        if params[:user_id]
           @user = User.find_by(id: params[:user_id])
           @items = @user.items.uniq
        elsif params[:name]
            @items = Item.item_search(params[:name])
        else
        @items = Item.all
        end
    end

    def new
        @item = Item.new
        @item.drinks.build
    end
    
    def show
    end

    
    def create
        @item = Item.new(item_params)
        if @item.save
          redirect_to item_path(@item)
        else
          render :new
        end
    end

    def edit
    end

    def update
        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            render :edit
        end
    end

    def destroy
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

      def set_item
        @item = Item.find_by(id: params[:id])
      end

end