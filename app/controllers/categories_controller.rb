class CategoriesController < ApplicationController
  # before_action :set_category_list,only:[:show]

  def index
    @parents = Category.all.where(ancestry: nil).limit(12);
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

  # private
  # def set_category_list
  #   @Category = Category.find(params[:id])
  # end
end
