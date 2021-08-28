class ItemsController < ApplicationController
    before_action :set_item, only: [:show]
    before_action :require_login

    def index
        if params[:user_id]
           @user = User.find_by(id: params[:user_id])
           @items = @user.items
        elsif params[:name]
            @items = Item.item_search(params[:name])
        elsif params[:filter]
          case params[:filter]
            when 'Alcohol'
              @items = Item.alcohol
            when 'Non-Alcohol'
              @items = Item.non_alcohol
            when 'View All'
              @items = Item.all
          end
        else
          @items = Item.all  
        end
    end

    def new
        @item = Item.new
        @item.drinks.build(user: current_user)
        @drinks = @item.drinks.select { |d| d.user_id == current_user.id }
    end
    
    def show
    end
    
    def create
        @item = Item.new(item_params)
        @item.drinks.each { |d|d.user_id = current_user.id }
        if @item.save
          flash[:message] = "New Item with a drink has been successfully created!"
          redirect_to item_path(@item)
        else
          @item.drinks.select { |d| d.user_id = current_user.id }
          render :new
        end
    end

    # since users share items, I don't want that if someone changes tha iten name to something else.
    # so I disabled `items#edit/update/destroy` 

    #def edit
    #  @drinks = @item.drinks.select { |d|d.user_id == current_user.id }
    #end

    #def update
    #  if @item.update(item_params)
    #    redirect_to item_path(@item)
    #  else
    #    @drinks = @item.drinks.select { |d|d.user_id == current_user.id }
    #    render :edit
    #  end
    #end

private

    def item_params
      params.require(:item).permit(
          :name,
          :image_url,
          :description,
          :alcohol, 
          drinks_attributes: [:drink_name, :drink_thumb, :recipe, :user_id, :id]
      )
  end


      def set_item
        @item = Item.find_by(id: params[:id])
      end

end