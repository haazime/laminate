require 'rails_helper'

describe 'Sign in' do
  context 'when signed up' do
    it do
      auth_hash = mock_auth_hash
      SignUpByOauthCommand.run(auth_hash)
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
end
