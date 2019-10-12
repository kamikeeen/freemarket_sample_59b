class CategoriesController < ApplicationController
  # before_action :set_category_list,only:[:show]

  def index
    @parentCategories = Category.where(ancestry: nil);
  end

  def new
  end

  def show
    @parentCategories = Category.where(ancestry: nil).page(params[:page]).per(5);
    
  end

  def edit
  end

  def destroy
  end

end
