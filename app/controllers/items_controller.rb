class ItemsController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :purchase, :buy]
  before_action :set_card, only: [:purchase, :buy]
  before_action :status_selling?, only: [:buy, :purchase, :edit, :update]
  before_action :buyer?, only: [:buy, :purchase]
  before_action :seller?, only: [:edit, :update]

  def index
  end

  def new
    @item = Item.new
    10.times {@item.images.build}
  end

  def create
    @item = Item.new(item_params)

    # usrは仮置き userログイン機能実装後は削除
    # @item.user_id = 1

    if @item.save
      redirect_to root_path
    else
      10.times {@item.images.build}
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.selling?
      @item.destroy if @item.user_id == current_user.id
      redirect_to listings_mypage_path
    else
      redirect_to item_path(params[:id])
    end
  end

  def purchase
  end


  private

  def item_params
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
    # )

    # userログイン機能実装後は下記に変更予定
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
    ).merge(user_id: current_user.id)
  end
    
  def image_build
    image_limit = 10
    (image_limit - @item.images.count).times {@item.images.build}
  end

  def set_card
    @card = current_user.card
  end

  def status_selling?
    if @item.status != "selling"
      redirect_to action: "show"
    end
  end

  def buyer?
    if @item.user_id == current_user.id
      redirect_to action: "show"
    end
  end

  def seller?
    if @item.user_id != current_user.id
      redirect_to action: "show"
    end
  end

end
