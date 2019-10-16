class BrandsController < ApplicationController
  require 'miyabi'
  before_action :set_ransack

  def index
    @brands = Brand.order('name Asc')
  end

  def show
    @brand = Brand.find(params[:id])
    @items = Item.where(brand_id: params[:id]).order('id Desc').page(params[:page]).per(5)
  end
end
