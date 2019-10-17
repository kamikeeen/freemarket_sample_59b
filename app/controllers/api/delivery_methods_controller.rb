class Api::DeliveryMethodsController < ApplicationController
  layout false

  def set
    item = Item.find(params[:item_id].to_s)
    @delivery_methods = (item.postage_side == "exhibitor") ? Item.delivery_methods_i18n : Item.limit_delivery_methods_i18n
    @delivery_method = item.delivery_method
  end

  def select
    @delivery_methods = (params[:postage_side] == "exhibitor") ? Item.delivery_methods_i18n : Item.limit_delivery_methods_i18n
  end
end