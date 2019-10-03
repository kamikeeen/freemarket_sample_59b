class CategoriesController < ApplicationController

  def index
    # @categories = Category.all
    @parents = Category.all.order("id ASC").limit(13);
  end

  def new
  end

  def show
  end

  def edit
  end

  def destroy
  end

end