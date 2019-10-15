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

  def dentification

  end

  def logout
    
  end

  def cards
    
  end

  def listings
    @items = current_user.items
  end

  private

  def really_current_user?
    if current_user.id != params[:id].to_i
      redirect_to root_path
    end
  end

end
