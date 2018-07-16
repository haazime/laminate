require 'rails_helper'

describe 'Sign up by Oauth' do
  context 'when valid' do
    it do
      auth_hash = mock_auth_hash

      r = PersonService.run(auth_hash)

      aggregate_failures do
        expect(r).to be_succeeded

        person = Person::Person.find_by_oauth_account(auth_hash['provider'], auth_hash['uid'])
        expect(person).to eq(Person::Person.find(r.person_id))

        expect(person.name).to eq(auth_hash['info']['name'])
        expect(person.email).to eq(auth_hash['info']['email'])
        expect(person.avatar_url).to eq(auth_hash['info']['image'])
      end
    end

    it do
      auth_hash = mock_auth_hash

      expect { PersonService.run(auth_hash) }
        .to change { Person::Person.count }.by(1)
        .and change { Person::OauthAccount.count }.by(1)
    end
  end

  context 'when already signed up' do
    it do
      auth_hash = mock_auth_hash
      PersonService.run(auth_hash)

      r = PersonService.run(auth_hash)

      aggregate_failures do
        expect(r).to_not be_succeeded
      end
    end

    it do
      auth_hash = mock_auth_hash
      PersonService.run(auth_hash)

      expect { PersonService.run(auth_hash) }
        .to change { Person::Person.count }.by(0)
        .and change { Person::OauthAccount.count }.by(0)
    end
  end
end
