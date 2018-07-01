class Apps::User < ApplicationRecord
  has_one :oauth_account

  class << self
    def find_by_oauth_account(provider, uid)
      joins(:oauth_account).find_by(apps_oauth_accounts: { provider: provider, uid: uid })
    end
  end
end
