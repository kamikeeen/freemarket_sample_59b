class MypagesController < ApplicationController
  
  before_action :really_current_user?

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
    @items = Item.where(user_id: current_user.id)
  end

  def dentification

  end

  def logout
    
  end

  def cards
    
  end

  private

  def really_current_user?
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end

end
