class Api::CategoriesController < ApplicationController
  layout false
  def set_children
    @children = Item.find(params[:item_id]).category.root.children
    @child = Item.find(params[:item_id].to_s).category.parent
  end

  def set_grand_children
    @grand_children = Item.find(params[:item_id]).category.parent.children
    @child = Item.find(params[:item_id].to_s).category
      render body: nil if @grand_children.empty?
  end

  def select_children
    @children = Category.find(params[:parent_id]).children
  end

  def select_grand_children
    @children_id = params[:children_id]
    @grand_children = Category.find(params[:children_id]).children
  end
end