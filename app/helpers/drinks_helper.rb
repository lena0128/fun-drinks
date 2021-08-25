module DrinksHelper

    def form_url_helper(item)
        item ? item_drinks_path(item) : drinks_path
    end
end
