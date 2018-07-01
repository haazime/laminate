require 'rails_helper'

describe 'Sign out' do
  context 'when signed in' do
    let(:user) { sign_up }

    before { sign_in(user) }

    it do
      sign_out

      aggregate_failures do
        expect(page).to have_content(I18n.t('navs.signed_out'))
        expect(page).to_not have_content(user.name)
      end
    end

    it do
      sign_out
      visit root_path

      expect(page).to have_content(I18n.t('navs.require_user'))
    end
  end
end
