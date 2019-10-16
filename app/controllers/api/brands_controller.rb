class Api::BrandsController < ApplicationController  
  def form
    @results = Brand.where("name LIKE(?)", "%#{params[:keyword]}%")
    respond_to do |format|
      format.json
    end
  end
end