require 'omniauth_test_helper'
require 'securerandom'

module OauthSupport
  module Common
    def set_auth_hash(auth_hash)
      OmniAuth.config.add_mock(auth_hash['provider'].to_sym, auth_hash)
    end

    def set_auth_hash_from_person(person)
      set_auth_hash(
        'provider' => person.oauth_account.provider,
        'uid' => person.oauth_account.uid
      )
    end

    def oauth_sign_up(auth_hash = mock_auth_hash)
      person_id = PersonService.sign_up_by_oauth!(auth_hash).person_id
      Person::Person.find(person_id)
    end
    alias_method :sign_up, :oauth_sign_up
  end

  module Request
    include Common

    def oauth_sign_in(auth_hash)
      set_auth_hash(auth_hash)
      request_oauth_sign_in
    end

    def sign_in(person)
      set_auth_hash_from_person(person)
      request_oauth_sign_in
    end

    def request_oauth_sign_in
      get '/auth/google_oauth2'
      follow_redirect!
      follow_redirect!
    end
  end

  module System
    def sign_in(person)
      set_auth_hash_from_person(person)
      visit new_session_path
      click_on 'Googleでログイン'
      find('#app_person_menu')
    end

    def sign_out
      find('#app_person_menu').click
      find('#app_sign_out').click
    end
  end
end

RSpec.configure do |c|
  c.include OauthSupport::Common
  c.include OauthSupport::Request, type: :request
  c.include OauthSupport::System, type: :system
end

OmniAuth.config.test_mode = true
OmniAuthTestHelper.register_generator do |g|
  g.for(:provider) { 'google_oauth2' }
  g.for(:uid) { SecureRandom.base64(14) }
  g.for(:name) { |h| "ユーザー #{h[:uid][0, 5]}"  }
  g.for(:email) { |h| "#{h[:uid]}@gmail.com" }
  g.for(:image) { |h| "https://photo/#{h[:uid]}.png" }
end
