require 'rails_helper'

describe 'Sign out' do
  context 'when signed in' do
    let(:user) { sign_up }

    before { sign_in(user) }

    it do
      delete '/session'
      follow_redirect!

      aggregate_failures do
        expect(response.body).to include(I18n.t('navs.signed_out'))
        expect(response.body).to_not include(user.name)
      end
    end

    it do
      delete '/session'
      follow_redirect!
      get root_path
      follow_redirect!

      expect(response.body).to include(I18n.t('navs.require_user'))
    end
  end
end
