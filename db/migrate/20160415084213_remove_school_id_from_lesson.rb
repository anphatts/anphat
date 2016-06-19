class RemoveSchoolIdFromLesson < ActiveRecord::Migration
  def change
    remove_foreign_key :lessons, name: "fk_lessons_schools1"
    remove_column :lessons, :school_id
  end
end
