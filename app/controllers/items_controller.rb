class ItemsController < ApplicationController
  require 'payjp'
  before_action :set_item, only: [:show, :purchase, :buy]
  before_action :set_card, only: [:purchase, :buy]

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
    @Category1 = Category.find(category1)
    @itemsCategory2 = Item.where(category_id: [Category.find(category2).descendant_ids]).order('id Desc').limit(10)
    @Category2 = Category.find(category2)
    @itemsCategory3 = Item.where(category_id: [Category.find(category3).descendant_ids]).order('id Desc').limit(10)
    @Category3 = Category.find(category3)
    @itemsCategory4 = Item.where(category_id: [Category.find(category4).descendant_ids]).order('id Desc').limit(10)
    @Category4 = Category.find(category4)

  end

  def new
    @item = Item.new
    10.times {@item.images.build}
  end

  def create
    @item = Item.new(item_params)
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
    if @card
      Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
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
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = current_user.card
  end

end
