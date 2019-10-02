# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook) #コールバック
  end
  
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    # binding.pry
    info = User.find_oauth(request.env["omniauth.auth"]) #usersモデルのメソッド
    @user = info[:user]
    @sns = info[:sns]
    # binding.pry
    if @sns.persisted? #snsが存在したら
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else #snsが存在しなかったら
      session["devise.sns_id"] = @sns[:id]
      session["devise.sns_uid"] = @sns[:uid]
      session["devise.sns_provider"] = @sns[:provider]
      # binding.pry
      if request.env['omniauth.origin'] == "http://localhost:3000/users/sign_in"
        render template: "users/sessions/new"
        session.clear
      else
        render template: "devise/registrations/new"
      # render template: "signups/new" #redirect_to だと更新してしまうのでrenderで
      end
    end
  end

  def failure
    redirect_to root_path and return
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
