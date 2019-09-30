class Api::SizesController < ApplicationController
  def select
    @child_sizes = Size.find(params[:size_id]).children
    render layout: false
  end
end