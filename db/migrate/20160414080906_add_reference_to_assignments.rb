class AddReferenceToAssignments < ActiveRecord::Migration
  def change
    add_foreign_key :assignments, :users
    add_foreign_key :assignments, :lessons
  end
end
