class ItemsController < ApplicationController

    def index
      @item = Item.new
      @item.images.build

      @items = Item.order(id Desc).limet(10)
      @images = Image.order(id Desc).limet(10)

      

      binding.pry
    end

    def create
      @item = Item.create(item_params)
    end

    def new
    end

    def show
    end

    def edit
    end

    def destroy
    end

    def purchase
    end

    private

    def item_params
      params.require(:item).permit(:name, :price, images_attributes: [:image])
    end

end