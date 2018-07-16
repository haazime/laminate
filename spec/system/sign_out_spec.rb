require 'rails_helper'

describe 'Sign out' do
  context 'when signed in' do
    let(:person) { sign_up }

    before { sign_in(person) }

    it do
      sign_out

      aggregate_failures do
        expect(page).to have_content(I18n.t('navs.signed_out'))
        expect(page).to_not have_content(person.name)
      end
    end

    it do
      sign_out
      visit root_path

      expect(page).to have_content(I18n.t('navs.ensure_signed_in'))
    end
  end
end
