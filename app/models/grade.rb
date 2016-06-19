class Grade < ActiveRecord::Base
  has_many :schools
  has_and_belongs_to_many :active_classes, join_table: "grade_has_classes", foreign_key: "grade_id", association_foreign_key: "class_id"
end
