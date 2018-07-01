class CreateAppsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :apps_users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :avatar_url, null: false

      t.timestamps
    end
  end
end
