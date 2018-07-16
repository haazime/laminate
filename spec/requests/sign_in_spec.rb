require 'rails_helper'

describe 'Sign in' do
  context 'when signed up' do
    it do
      sign_up # other person

      auth_hash = mock_auth_hash
      sign_up(auth_hash)

      oauth_sign_in(auth_hash)

      aggregate_failures do
        expect(response.body).to include(I18n.t('navs.signed_in'))
        expect(response.body).to include(auth_hash['info']['name'])
      end
    end
  end

  context 'when signed in' do
    it do
      auth_hash = mock_auth_hash
      oauth_sign_in(auth_hash)

      oauth_sign_in(auth_hash)

      expect(response.body).to include(I18n.t('navs.already_signed_in'))
    end
  end
end
