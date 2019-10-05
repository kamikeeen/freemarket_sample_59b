# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook) #コールバック
  end
  
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    info = User.find_oauth(request.env["omniauth.auth"]) #usersモデルのメソッド
    @user = info[:user]
    @sns = info[:sns]
    if @sns.persisted? #snsが存在したら
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else #snsが存在しなかったら
      session["devise.sns_id"] = @sns[:id]
      session["devise.sns_uid"] = @sns[:uid]
      session["devise.sns_provider"] = @sns[:provider]
      if request.env['omniauth.origin'] == "http://localhost:3000/signups"
        render template: "devise/registrations/new"
      # render template: "signups/new" #redirect_to だと更新してしまうのでrenderで
      else
        back_to_login_page
      end
    end
  end

  def failure
    redirect_to root_path and return
  end

  def back_to_login_page
    @backprovider = session["devise.sns_provider"]
    session.clear
    @user = User.new
    @sns = SnsCredential.new
    render template: "users/sessions/new"
  end



  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
