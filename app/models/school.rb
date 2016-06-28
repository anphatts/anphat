class School < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :grade_id, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :grade
  belongs_to :phongdaotao, class_name: "School", foreign_key: "pdt_id"
  has_many :belonged_school, class_name: "School", foreign_key: "pdt_id", dependent: :nullify
  has_many :users, foreign_key: "school_id", dependent: :nullify
  def active_classes
    return grade.active_classes
  end
end