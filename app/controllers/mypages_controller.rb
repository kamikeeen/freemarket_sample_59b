class MypagesController < ApplicationController

  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def listings
    @item = Item.where(user_id: "1").first
    binding.pry
  end

  def dentification

  end

  def logout
    
  end

  def cards
    
  end

end
