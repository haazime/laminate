class CreatePersonPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :person_people do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :avatar_url, null: false

      t.timestamps
    end
  end
end
