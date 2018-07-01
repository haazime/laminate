class Apps::User < ApplicationRecord
  has_one :oauth_account

  class << self
    def create_with_oauth_account!(user_params, oauth_account_params)
      new(user_params) do |u|
        u.build_oauth_account(oauth_account_params)
        u.save!
      end
    end

    def find_by_oauth_account(provider, uid)
      joins(:oauth_account).find_by(apps_oauth_accounts: { provider: provider, uid: uid })
    end
  end
end
