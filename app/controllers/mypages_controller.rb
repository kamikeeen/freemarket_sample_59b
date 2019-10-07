class MypagesController < ApplicationController

  def index
  end

  def new
  end

  def show
    @user = User.find(current_user.id)
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

end
