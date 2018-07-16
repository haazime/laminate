class Person::Person < ApplicationRecord
  has_one :oauth_account, foreign_key: 'person_person_id'

  class << self
    def new_with_oauth_account(person_params, oauth_account_params)
      new(person_params) do |u|
        u.build_oauth_account(oauth_account_params)
      end
    end

    def find_by_oauth_account(provider, uid)
      joins(:oauth_account).find_by(person_oauth_accounts: { provider: provider, uid: uid })
    end
  end

  def add_project_member(project_member)
  end
end
