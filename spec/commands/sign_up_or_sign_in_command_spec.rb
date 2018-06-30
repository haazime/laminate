require 'rails_helper'

describe SignUpOrSignInCommand do
  it do
    auth_hash = mock_auth_hash

    r = described_class.run(auth_hash)

    aggregate_failures do
      user = Apps::User.find_by(id: r.user_id)

      expect(r).to be_succeeded
      expect(user.oauth_account).to eq(Apps::OauthAccount.new(auth_hash['provider'], auth_hash['uid']))
      expect(user.profile).to eq(Apps::UserProfile.new(auth_hash['info']))
    end
  end
end
