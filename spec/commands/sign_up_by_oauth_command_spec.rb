require 'rails_helper'

describe SignUpByOauthCommand do
  context 'when valid' do
    it do
      auth_hash = mock_auth_hash

      r = described_class.run(auth_hash)

      aggregate_failures do
        expect(r).to be_succeeded

        user = Apps::User.find_by_oauth_account(auth_hash['provider'], auth_hash['uid'])
        expect(user).to eq(Apps::User.last)

        expect(user.name).to eq(auth_hash['info']['name'])
        expect(user.email).to eq(auth_hash['info']['email'])
        expect(user.avatar_url).to eq(auth_hash['info']['image'])
      end
    end

    it do
      auth_hash = mock_auth_hash

      expect { described_class.run(auth_hash) }
        .to change { Apps::User.count }.by(1)
        .and change { Apps::OauthAccount.count }.by(1)
    end
  end

  context 'when already signed up' do
    it do
      auth_hash = mock_auth_hash
      described_class.run(auth_hash)

      r = described_class.run(auth_hash)

      aggregate_failures do
        expect(r).to_not be_succeeded
      end
    end

    it do
      auth_hash = mock_auth_hash
      described_class.run(auth_hash)

      expect { described_class.run(auth_hash) }
        .to change { Apps::User.count }.by(0)
        .and change { Apps::OauthAccount.count }.by(0)
    end
  end
end
