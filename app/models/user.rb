class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :friends, -> { where(friendships: { status: "accepted" }) }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where(friendships: { status: "pending" }) }, through: :friendships, source: :friend
  has_many :friend_requests, -> { where(friendships: { status: "pending" }) }, through: :inverse_friendships, source: :user

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end