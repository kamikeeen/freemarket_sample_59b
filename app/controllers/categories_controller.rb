class CategoriesController < ApplicationController

  before_action :set_ransack

  def index
    @parentCategories = Category.where(ancestry: nil)
  end

  def new
  end

  def show
    @parentCategories = Category.where(ancestry: nil)

    if Category.find(params[:id]).has_children?
      @items = Item.where(category_id: Category.find(params[:id]).descendant_ids).order('id Desc').page(params[:page]).per(100)
    else
      @items = Item.where(category_id: params[:id]).order('id Desc').page(params[:page]).per(100)
    end

    @category = Category.find(params[:id])
    
  end

  def edit
  end

  def destroy
  end

end
