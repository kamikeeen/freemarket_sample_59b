class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update]

  def index
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
    # if @item.user.id == current_user
      (10 - @item.images.count).times {@item.images.build}
    # else
    #   redirect_to root_path
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path(params[:id])
    else
      (10 - @item.images.count).times {@item.images.build}
      render :edit
    end
  end

  def destroy
  end

  def purchase
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

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
        :id,
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
    #     :id,
    #     :name
    #   ]
    # ).merge(user_id: current_user.id)
  end
end
