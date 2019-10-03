class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true
  with_options on: :back_to_login_page do |back_to_login_page|
    back_to_login_page.validates :uid,                presence: true, uniqueness: true
    back_to_login_page.validates :provider,           presence: true, uniqueness: true
    back_to_login_page.validates :user_id,            presence: true
  end
end
