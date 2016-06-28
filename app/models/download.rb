class Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson, foreign_key: "lesson_id"
  validates :user_id, uniqueness: { scope: :lesson_id }
end