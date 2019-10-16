class ItemsController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :purchase, :buy]
  before_action :set_card, only: [:purchase, :buy]
  before_action :can_buy?, only: [:buy, :purchase]
  before_action :seller?, only: [:edit, :update]

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
      
      brands = [724, 4356, 6071, 6198, 9716]
      recommenndBrands = brands.sample(4)
  
      brand1 = recommenndBrands[0]
      brand2 = recommenndBrands[1]
      brand3 = recommenndBrands[2]
      brand4 = recommenndBrands[3]
    end

    @itemsCategory1 = Item.where(category_id: [Category.find(category1).descendant_ids]).order('id Desc').limit(10)
    @CategoryName1 = Category.find(category1).name
    @itemsCategory2 = Item.where(category_id: [Category.find(category2).descendant_ids]).order('id Desc').limit(10)
    @CategoryName2 = Category.find(category2).name
    @itemsCategory3 = Item.where(category_id: [Category.find(category3).descendant_ids]).order('id Desc').limit(10)
    @CategoryName3 = Category.find(category3).name
    @itemsCategory4 = Item.where(category_id: [Category.find(category4).descendant_ids]).order('id Desc').limit(10)
    @CategoryName4 = Category.find(category4).name

    @grandCategory = Category.all.where(ancestry: nil)

    @itemsBrand1 = Item.where(brand_id: [Brand.find(brand1).id]).order('id Desc').limit(10)
    @Brand1 = Brand.find(brand1)
    @itemsBrand2 = Item.where(brand_id: [Brand.find(brand2).id]).order('id Desc').limit(10)
    @Brand2 = Brand.find(brand2)
    @itemsBrand3 = Item.where(brand_id: [Brand.find(brand3).id]).order('id Desc').limit(10)
    @Brand3 = Brand.find(brand3)
    @itemsBrand4 = Item.where(brand_id: [Brand.find(brand4).id]).order('id Desc').limit(10)
    @Brand4 = Brand.find(brand4)
  end

  def new
    @item = Item.new
    image_build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      image_build
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @before_item = @item.previous
    @after_item = @item.next

    @another_items = Item.where(user_id: @item.user_id).where.not(id: @item.id).limit(6)
    if @item.brand_id
      @brand_items = Item.where(brand_id: @item.brand_id).where.not(id: @item.id).limit(6)
    end
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

