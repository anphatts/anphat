class ActiveClass < ActiveRecord::Base
  self.table_name = "classes"
  has_and_belongs_to_many :schools, join_table: "school_has_classes", foreign_key: "class_id"
  has_many :lessons, foreign_key: "class_id"
  has_many :subjects, join_table: "class_has_subject"
  accepts_nested_attributes_for :lessons
  has_and_belongs_to_many :subjects, join_table: "class_has_subjects", foreign_key: "class_id"
end
