class ItemsController < ApplicationController

    def index
      @item = Item.new
      @item.images.build

      @items = Item.order('id Desc').limit(10)
      @images = Image.order('id Desc').limit(10)
      # @item-brandとimage-category

    end

    def new
      @item = Item.new
      @item.images.build
    end

    def create
      @item = Item.new(item_params)
      @item.user_id = 1
      @item.save
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
    params.require(:item).permit(:name, :text, :size_id, :category_id, :damage, :postage_side, :prefecture_id, :delivery_method, :arrival, :price, images_attributes: [:name])
  end

end
