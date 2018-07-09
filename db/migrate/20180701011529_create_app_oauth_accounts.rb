class CreateAppOauthAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :app_oauth_accounts do |t|
      t.integer :user_id, null: false, index: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end

    add_foreign_key :app_oauth_accounts, :app_users, column: :user_id
    add_index :app_oauth_accounts, [:provider, :uid], unique: true
  end
end
