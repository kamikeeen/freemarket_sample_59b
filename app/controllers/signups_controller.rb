class SignupsController < ApplicationController

  def index
  end

  def signin
  end

  def registration
    @user = User.new
  end

  def sms_confirmation
    @user = User.new
  end

  def sms
  end

  def address
    @user = User.new
    @user.addresses.build
  end

  def payment
  end

  def end
  end

end
