class Api::DeliveryMethodsController < ApplicationController
  layout false

  def set
    @delivery_methods = (params[:postage_side] == "exhibitor") ? Item.delivery_methods_i18n : Item.limit_delivery_methods_i18n
    @delivery_method = Item.find(params[:item_id].to_s).delivery_method
  end

  def select
    @delivery_methods = (params[:postage_side] == "exhibitor") ? Item.delivery_methods_i18n : Item.limit_delivery_methods_i18n
  end
end