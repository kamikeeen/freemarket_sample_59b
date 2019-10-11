class CategoriesController < ApplicationController
  # before_action :set_category_list,only:[:show]

  def index
    @parentCategories = Category.where(ancestry: nil);
  end

  def new
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
  end

  def destroy
  end

end
