class Api::SizesController < ApplicationController
  layout false
  
  def select
    @child_sizes = Size.find(params[:size_id]).children
  end
end