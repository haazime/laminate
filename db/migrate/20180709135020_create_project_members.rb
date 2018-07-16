class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|
      t.integer :project_id, null: false, index: true

      t.timestamps
    end
  end
end
