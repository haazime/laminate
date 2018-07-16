class CreatePersonOauthAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :person_oauth_accounts do |t|
      t.references :person_person, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end

    add_index :person_oauth_accounts, [:provider, :uid], unique: true
  end
end
