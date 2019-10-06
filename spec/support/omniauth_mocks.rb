module OmniauthMocks
  def facebook_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: "facebook",
      uid: "123456",
      info: {
        email: "mock@example.com",
        name: "Mock User",
        image: "http://mock_image_url.com",
      },
      credentials: {
        token: "mock_credentails_token",
        expires_at: 1234567890,
        expires: true
      },
      extra: {
        raw_info: {
          name: "Mock User",
          email: "mock@example.com",
          id: "123456",
        }
      }
    })
  end
  def facebook_invalid_mock
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentails
  end
end