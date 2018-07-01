require 'rails_helper'

describe 'Sign up' do
  context 'when NOT signed up' do
    it do
      auth_hash = mock_auth_hash
      set_auth_hash(auth_hash)

      get '/auth/google_oauth2'
      follow_redirect!
      follow_redirect!

      aggregate_failures do
        expect(response.body).to include(I18n.t('navs.sign_in.succeeded'))
        expect(response.body).to include(auth_hash['info']['name'])
      end
    end
  end

  context 'when signed in' do
  end
end
