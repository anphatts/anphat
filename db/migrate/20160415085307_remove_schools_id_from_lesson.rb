class RemoveSchoolsIdFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :schools_id
  end
end
