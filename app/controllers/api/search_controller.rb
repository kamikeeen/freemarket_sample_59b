class Api::SearchController < ApplicationController
  layout false
  
  def select_children
    @parent_id = params[:parent_id]
    @children = Category.find(params[:parent_id]).children
  end

  def select_grand_children
    @children_id = params[:children_id]
    @grand_children = Category.find(params[:children_id]).children
      render body: nil if @grand_children.empty?
  end

  def select_size
    @size_chirdren_id = Size.find(params[:size_parent_id]).children
  end
end