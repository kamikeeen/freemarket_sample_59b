class Api::SizesController < ApplicationController
  layout false
  
  def set
    @child_sizes = Size.find(params[:size_id]).children
    @child_size = Item.find(params[:item_id]).size
  end

  def select
    @child_sizes = Size.find(params[:size_id]).children
  end
end