class ItemsController < ApplicationController

    def index
      @item = Item.new
      @item.images.build

      # categories = [1, 200, 680, 893, 1088]
      # categoryNumber = [category1 = 0, category2 = 0, category3 = 0, category4 = 0] 

      # recommenndCategories = categories.sample(4)
      # recommenndCategories.zip(categoryNumber).each do |c, n|
      #   n = c
      # end

      category1 = 1
      category2 = 200
      category3 = 893
      category4 = 680

      @itemsCategory1 = Item.where(category_id: [Category.find(category1).descendant_ids]).order('id Desc').limit(10)
      @imagesCategory1 = Image.find(@itemsCategory1.ids)
      @CategoryName1 = Category.find(category1).name
      @itemsCategory2 = Item.where(category_id: [Category.find(category2).descendant_ids]).order('id Desc').limit(10)
      @imagesCategory2 = Image.find(@itemsCategory2.ids)
      @CategoryName2 = Category.find(category2).name
      @itemsCategory3 = Item.where(category_id: [Category.find(category3).descendant_ids]).order('id Desc').limit(10)
      @imagesCategory3 = Image.find(@itemsCategory3.ids)
      @CategoryName3 = Category.find(category3).name
      @itemsCategory4 = Item.where(category_id: [Category.find(category4).descendant_ids]).order('id Desc').limit(10)
      @imagesCategory4 = Image.find(@itemsCategory4.ids)
      @CategoryName4 = Category.find(category4).name

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
