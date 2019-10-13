class CategoriesController < ApplicationController
  # before_action :set_category_list,only:[:show]

  def index
    @parentCategories = Category.where(ancestry: nil);
  end

  def new
  end

  def show
    @parentCategories = Category.where(ancestry: nil).page(params[:page]).per(5)
    if Category.find(params[:id]).has_children? then
      @items = Item.where(category_id: Category.find(params[:id]).descendant_ids).order('id Desc')
    else
      @items = Item.where(category_id: params[:id]).order('id Desc')
    end
    
  end

  def edit
  end

  def destroy
  end

end
