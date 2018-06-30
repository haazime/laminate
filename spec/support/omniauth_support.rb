require 'omniauth_test_helper'
require 'securerandom'

OmniAuth.config.test_mode = true
OmniAuthTestHelper.register_generator do |g|
  g.for(:provider) { 'google_oauth2' }
  g.for(:uid) { SecureRandom.base64(14) }
  g.for(:name) { |h| "ユーザー #{h[:uid][0, 5]}"  }
  g.for(:email) { |h| "#{h[:uid]}@gmail.com" }
  g.for(:image) { |h| "https://photo/#{h[:uid]}.png" }
end
