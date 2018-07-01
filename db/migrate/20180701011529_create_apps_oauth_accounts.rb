class CreateAppsOauthAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :apps_oauth_accounts do |t|
      t.integer :user_id, null: false, index: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end

    add_foreign_key :apps_oauth_accounts, :apps_users, column: :user_id
    add_index :apps_oauth_accounts, [:provider, :uid], unique: true
  end
end
