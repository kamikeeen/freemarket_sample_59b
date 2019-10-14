class ItemsController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :purchase, :buy]
  before_action :set_card, only: [:purchase, :buy]
  before_action :can_buy?, only: [:buy, :purchase]
  before_action :seller?, only: [:edit, :update]

  def index
  end

  def new
    @item = Item.new
    image_build
  end

  def create
    @item = Item.new(item_params)

    # usrは仮置き userログイン機能実装後は削除
    # @item.user_id = 1

    if @item.save
      redirect_to root_path
    else
      image_build
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @another_items = Item.where(user_id: @item.user_id).where.not(id: @item.id).limit(6)
  end

  def edit
      @item.images.each do |image|
        image.name.cache!
      end
      image_build
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      image_build
      render :edit
    end
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
  
  def buy
    if @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
      Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy',
      )
      if @item.update(status: 1, buyer_id: current_user.id)
        redirect_to item_path(params[:id])
      else
        redirect_to item_path(params[:id])
      end
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

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
      :brand_id,
      images_attributes: [
        :id,
        :name,
        :name_cache
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

  def can_buy?
    if @item.status != "selling" || @item.user_id == current_user.id
      redirect_to action: "show"
    end
  end

  def seller?
    if @item.user_id != current_user.id
      redirect_to action: "show"
    end
  end

end

