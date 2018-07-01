require 'rails_helper'

RSpec.describe Apps::User, type: :model do
  it do
    user = described_class.new_with_oauth_account(
      {
        name: 'User Name',
        email: 'email@example.com',
        avatar_url: 'http://avatar.url'
      },
      {
        provider: 'google_oauth2',
        uid: 'oauth_uid'
      }
    )

    aggregate_failures do
      expect(user.name).to eq('User Name')
      expect(user.email).to eq('email@example.com')
      expect(user.avatar_url).to eq('http://avatar.url')
      expect(user.oauth_account.provider).to eq('google_oauth2')
      expect(user.oauth_account.uid).to eq('oauth_uid')
    end
  end
end
