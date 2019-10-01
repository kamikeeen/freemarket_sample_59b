class Api::DeliveryMethodsController < ApplicationController
  layout false

  def select
    @delivery_methods = (params[:postage_side] == "exhibitor") ? Item.delivery_methods_i18n : Item.limit_delivery_methods_i18n
    # if postage_side == "exhibitor"
    #   @delivery_methods = Item.delivery_methods_i18n
    # else
    #   @delivery_methods = Item.limit_delivery_methods_i18n
    # end
  end
end