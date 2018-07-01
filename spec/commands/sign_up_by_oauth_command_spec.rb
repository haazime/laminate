require 'rails_helper'

describe SignUpByOauthCommand do
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
end
