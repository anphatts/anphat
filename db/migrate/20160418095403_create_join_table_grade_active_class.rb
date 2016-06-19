class CreateJoinTableGradeActiveClass < ActiveRecord::Migration
  def change
    create_join_table :grades, :classes, table_name: :grade_has_classes do |t|
       t.index [:grade_id, :class_id]
       t.index [:class_id, :grade_id]
    end
    add_foreign_key :grade_has_classes, :grades
    add_foreign_key :grade_has_classes, :classes
  end
end
