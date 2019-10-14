class Api::DeliveryMethodsController < ApplicationController
  layout false

  def select
    @delivery_methods = (params[:postage_side] == "exhibitor") ? Item.delivery_methods_i18n : Item.limit_delivery_methods_i18n
  end
end