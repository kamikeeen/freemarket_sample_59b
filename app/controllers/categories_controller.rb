class CategoriesController < ApplicationController

  def index
    @parents = Category.all.where(ancestry: nil).limit(12);
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