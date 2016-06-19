class CreateAssignments < ActiveRecord::Migration
  def change
    create_join_table :users, :lessons, table_name: :assignments do |t|
      t.index :user_id
      t.index :lesson_id
    end
  end
end
