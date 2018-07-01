require 'omniauth_test_helper'
require 'securerandom'

module OauthSupport
  module Common
    def set_auth_hash(auth_hash)
      OmniAuth.config.add_mock(auth_hash['provider'].to_sym, auth_hash)
    end

    def oauth_sign_up(auth_hash = mock_auth_hash)
      user_id = SignUpByOauthCommand.run!(auth_hash).user_id
      Apps::User.find(user_id)
    end
  end

  module Request
    include Common

    def oauth_sign_in(auth_hash)
      set_auth_hash(auth_hash)

      get '/auth/google_oauth2'
      follow_redirect!
      follow_redirect!
    end
  end
end

RSpec.configure do |c|
  c.include OauthSupport::Common
  c.include OauthSupport::Request, type: :request
end

OmniAuth.config.test_mode = true
OmniAuthTestHelper.register_generator do |g|
  g.for(:provider) { 'google_oauth2' }
  g.for(:uid) { SecureRandom.base64(14) }
  g.for(:name) { |h| "ユーザー #{h[:uid][0, 5]}"  }
  g.for(:email) { |h| "#{h[:uid]}@gmail.com" }
  g.for(:image) { |h| "https://photo/#{h[:uid]}.png" }
end
