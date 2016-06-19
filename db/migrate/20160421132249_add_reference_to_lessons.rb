class AddReferenceToLessons < ActiveRecord::Migration
  def change
    add_foreign_key :lessons, :users, name: "approver"
  end
end
