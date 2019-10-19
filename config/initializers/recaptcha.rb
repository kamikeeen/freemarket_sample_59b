Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.RECAPTCHA_PUBLIC_KEY
  config.secret_key = Rails.application.credentials.RECAPTCHA_PRIVATE_KEY
end