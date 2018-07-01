require 'rails_helper'

describe 'Sign up' do
  context 'when NOT signed up' do
    it do
      auth_hash = mock_auth_hash
      OmniAuth.config.add_mock(auth_hash['provider'].to_sym, auth_hash)

      get '/auth/google_oauth2'
      follow_redirect!
      follow_redirect!

      expect(response.body).to include(auth_hash['info']['name'])
    end
  end
end
