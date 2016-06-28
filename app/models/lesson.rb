class Lesson < ActiveRecord::Base
  acts_as_commontable

  is_impressionable
  self.table_name = "lessons"
  mount_uploader :url, UrlUploader # Tells rails to use this uploader for this model.
  mount_uploader :represent_image, RepresentImageUploader
  belongs_to :user
  belongs_to :active_class, foreign_key: "class_id"
  accepts_nested_attributes_for :active_class
  has_many :comments, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :persons_in_charge, through: :assignments, source: :user, dependent: :destroy
  has_many :downloads
  has_many :download_users, through: :downloads, source: :user, dependent: :destroy
  belongs_to :approver, class_name: "User", foreign_key: "approver_id"

  validates :user_id, presence: true
  validates :url, presence: true, file_size: { less_than: 150.megabytes, message: 'File dữ liệu phải nhỏ hơn %{count}' }
  validates :represent_image, file_content_type: { allow: ['image/jpeg', 'image/png'], message: 'chỉ được sử dụng %{type}' }
  validates :name, presence: true
  validates :class_id, presence: { message: 'Lớp không được bỏ trống' }
  default_scope -> { order(created_at: :desc) }
end
