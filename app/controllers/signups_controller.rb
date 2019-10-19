class SignupsController < ApplicationController
  
  before_action :validates_registration, only: :sms_confirmation
  before_action :validates_sms_confirmation, only: :address
  before_action :validates_address, only: :create
  before_action :already_signed_in?

  def index
  end
  
  def signin_sms
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
    @address = Address.new
  end

  def payment
    @user = User.new
  end

  def end
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      familyname: session[:familyname],
      firstname: session[:firstname],
      familyname_kana: session[:familyname_kana],
      firstname_kana: session[:firstname_kana],
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      phone_number: session[:phone_number]
    )
    @user.addresses.build(
      familyname: session[:family_name],
      firstname: session[:first_name],
      familyname_kana: session[:family_name_kana],
      firstname_kana: session[:first_name_kana],
      zip_code: session[:zip_code],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address_line: session[:address_line],
      building_name: session[:building_name],
      phone_number: session[:phonenumber]
    )
    if @user.save
      session[:id] = @user.id
      redirect_to end_signups_path
      if session["devise.sns_uid"].present?
        SnsCredential.create(uid: session["devise.sns_uid"] , provider: session["devise.sns_provider"], user_id: @user.id) 
      end
    else
      render 'payment'
    end
  end


  def validates_registration
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:familyname] = harf_to_full(user_params[:familyname])
    session[:firstname] = harf_to_full(user_params[:firstname])
    session[:familyname_kana] = harf_to_full(user_params[:familyname_kana])
    session[:firstname_kana] = harf_to_full(user_params[:firstname_kana])
    session["birthday(1i)"] = user_params["birthday(1i)"]
    session["birthday(2i)"] = user_params["birthday(2i)"]
    session["birthday(3i)"] = user_params["birthday(3i)"]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      familyname: session[:familyname],
      firstname: session[:firstname],
      familyname_kana: session[:familyname_kana],
      firstname_kana: session[:firstname_kana],
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      phone_number: "09099999999"
    )
    render 'registration' unless (@user.valid? && verify_recaptcha(model: @user))
  end

  def validates_sms_confirmation
    session[:phone_number] = modify_phone_number(user_params[:phone_number])
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      familyname: session[:familyname],
      firstname: session[:firstname],
      familyname_kana: session[:familyname_kana],
      firstname_kana: session[:firstname_kana],
      "birthday(1i)": session["birthday(1i)"],
      "birthday(2i)": session["birthday(2i)"],
      "birthday(3i)": session["birthday(3i)"],
      phone_number: session[:phone_number]
    )
    render 'sms_confirmation' unless @user.valid?
  end

  def validates_address
    session[:family_name] = user_params[:addresses_attributes]["0"][:familyname]
    session[:first_name] = user_params[:addresses_attributes]["0"][:firstname_kana]
    session[:family_name_kana] = user_params[:addresses_attributes]["0"][:familyname_kana]
    session[:first_name_kana] = user_params[:addresses_attributes]["0"][:firstname_kana]
    session[:zip_code] = user_params[:addresses_attributes]["0"][:zip_code]
    session[:prefecture_id] = user_params[:addresses_attributes]["0"][:prefecture_id]
    session[:city] = user_params[:addresses_attributes]["0"][:city]
    session[:address_line] = user_params[:addresses_attributes]["0"][:address_line]
    session[:building_name] = user_params[:addresses_attributes]["0"][:building_name]
    session[:phonenumber] = user_params[:addresses_attributes]["0"][:phone_number]
    @address = Address.new(
      familyname: session[:family_name],
      firstname: session[:first_name],
      familyname_kana: session[:family_name_kana],
      firstname_kana: session[:first_name_kana],
      zip_code: session[:zip_code],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address_line: session[:address_line],
      building_name: session[:building_name],
      phone_number: session[:phonenumber]
    )
    if @address.invalid?
      @user = User.new
      @user.addresses.build(
        familyname: session[:family_name],
        firstname: session[:first_name],
        familyname_kana: session[:family_name_kana],
        firstname_kana: session[:first_name_kana],
        zip_code: session[:zip_code],
        prefecture_id: session[:prefecture_id],
        city: session[:city],
        address_line: session[:address_line],
        building_name: session[:building_name],
        phone_number: session[:phonenumber]
      )
      render 'address'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :familyname,
      :firstname,
      :familyname_kana,
      :firstname_kana,
      :birthday,
      :phone_number,
      addresses_attributes: [
        :familyname,
        :firstname,
        :familyname_kana,
        :firstname_kana,
        :zip_code,
        :prefecture_id,
        :city,
        :address_line,
        :building_name,
        :phone_number
      ]
    )
  end

  # 半角から全角へ変換
  def harf_to_full(str)
    str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
  end

  #電話番号のハイフンを取り除く
  def modify_phone_number(number)
    str = number.tr('０-９', '0-9').to_s
    str.gsub(/-/, "")
  end

  def already_signed_in?
    if user_signed_in?
      redirect_to root_path
    end
  end

end
