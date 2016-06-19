class Subject < ActiveRecord::Base
  has_and_belongs_to_many :active_classes, join_table: "class_has_subject"
end
