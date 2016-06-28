class User < ActiveRecord::Base
  acts_as_commontator

  has_many :lessons, dependent: :destroy
  has_many :comments
  accepts_nested_attributes_for :lessons
  belongs_to :school
  has_and_belongs_to_many :roles, join_table: "user_has_role", foreign_key: "user_id"
  has_many :assignments, dependent: :delete_all
  has_many :downloads
  has_many :assigned_lessons, through: :assignments, source: :lesson
  has_many :download_lessons, through: :downloads, source: :lesson

  attr_accessor :remember_token

  validates :name, presence: true, length: {maximum: 50}
  validates :username,  presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a users in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a users.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
