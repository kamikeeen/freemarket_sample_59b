class CategoriesController < ApplicationController
  # before_action :set_category_list,only:[:show]

  def index
    @parentCategories = Category.where(ancestry: nil)
  end

  def new
  end

  def show
    @parentCategories = Category.where(ancestry: nil)

    if Category.find(params[:id]).has_children? then
      @items = Item.where(category_id: Category.find(params[:id]).descendant_ids).order('id Desc').page(params[:page]).per(5)
    else
      @items = Item.where(category_id: params[:id]).order('id Desc').page(params[:page]).per(5)
    end

    @category = Category.find(params[:id])
    
  end

  def edit
  end

  def destroy
  end

end
