require 'rails_helper'

RSpec.describe Person::Person, type: :model do
  it do
    person = described_class.new_with_oauth_account(
      {
        name: 'Person Name',
        email: 'email@example.com',
        avatar_url: 'http://avatar.url'
      },
      {
        provider: 'google_oauth2',
        uid: 'oauth_uid'
      }
    )

    aggregate_failures do
      expect(person.name).to eq('Person Name')
      expect(person.email).to eq('email@example.com')
      expect(person.avatar_url).to eq('http://avatar.url')
      expect(person.oauth_account.provider).to eq('google_oauth2')
      expect(person.oauth_account.uid).to eq('oauth_uid')
    end
  end
end
