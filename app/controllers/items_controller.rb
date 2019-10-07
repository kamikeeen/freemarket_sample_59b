class ItemsController < ApplicationController

  def index
    if Rails.env == "test" then
      category1 = 1
      category2 = 200
      category3 = 680
      category4 = 893
    else
      categories = [1, 200, 680, 893, 1088]
      recommenndCategories = categories.sample(4)

      category1 = recommenndCategories[0]
      category2 = recommenndCategories[1]
      category3 = recommenndCategories[2]
      category4 = recommenndCategories[3]

    end

    @itemsCategory1 = Item.where(category_id: [Category.find(category1).descendant_ids]).order('id Desc').limit(10)
    @CategoryName1 = Category.find(category1).name
    @itemsCategory2 = Item.where(category_id: [Category.find(category2).descendant_ids]).order('id Desc').limit(10)
    @CategoryName2 = Category.find(category2).name
    @itemsCategory3 = Item.where(category_id: [Category.find(category3).descendant_ids]).order('id Desc').limit(10)
    @CategoryName3 = Category.find(category3).name
    @itemsCategory4 = Item.where(category_id: [Category.find(category4).descendant_ids]).order('id Desc').limit(10)
    @CategoryName4 = Category.find(category4).name

  end

  def new
    @item = Item.new
    10.times {@item.images.build}
  end

  def create
    @item = Item.new(item_params)

    # usrは仮置き userログイン機能実装後は削除
    @item.user_id = 1

    if @item.save
      redirect_to root_path
    else
      10.times {@item.images.build}
      render :new
    end
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
    params.require(:item).permit(
      :name, 
      :text, 
      :size_id, 
      :category_id, 
      :damage, 
      :postage_side, 
      :prefecture_id, 
      :delivery_method, 
      :arrival, 
      :price, 
      images_attributes: [
        :name
      ]
    )

    # userログイン機能実装後は下記に変更予定
    # params.require(:item).permit(
    #   :name, 
    #   :text, 
    #   :size_id, 
    #   :category_id, 
    #   :damage, 
    #   :postage_side, 
    #   :prefecture_id, 
    #   :delivery_method, 
    #   :arrival, 
    #   :price, 
    #   images_attributes: [
    #     :name
    #   ]
    # ).merge(user_id: current_user.id)
  end

end
