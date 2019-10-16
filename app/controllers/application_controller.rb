class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception


  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth_user && password == Rails.application.credentials.basic_auth_password
    end
  end

  def set_grandCategory
    @grandCategory = Category.where(ancestry: nil)
  end
  
  def set_ransack
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).page(params[:page]).per(24)
  end
end
