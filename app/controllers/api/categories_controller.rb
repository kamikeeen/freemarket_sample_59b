class Api::CategoriesController < ApplicationController
  layout false

  def select_children
    @children = Category.find(params[:parent_id]).children
  end

  def select_grand_children
    @grand_children = Category.find(params[:children_id]).children
      render body: nil if @grand_children.empty?
  end
end