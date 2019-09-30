class Api::CategoriesController < ApplicationController

  def select_children
    @children = Category.find(params[:parent_id]).children
    render layout: false
  end

  def select_grand_children
    @grand_children = Category.find(params[:children_id]).children
    render layout: false
  end
end