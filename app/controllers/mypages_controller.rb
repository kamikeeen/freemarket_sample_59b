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
    binding.pry
  end

  def listings
    @items = Item.where(user_id: current_user.id)
  end

  def dentification

  end

  def logout
    
  end

  def cards
    
  end

end
