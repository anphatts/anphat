class AddIsassignmentToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :isAssignment, :bool, default: false
  end
end
