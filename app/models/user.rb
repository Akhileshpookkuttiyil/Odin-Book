class User < ApplicationRecord
has_many :posts, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :likes, dependent: :destroy

has_many :friendships, dependent: :destroy
has_one_attached :avatar
has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy

has_many :friends, -> { where(friendships: { status: "accepted" }) }, through: :friendships, source: :friend
has_many :pending_friends, -> { where(friendships: { status: "pending" }) }, through: :friendships, source: :friend
has_many :friend_requests, -> { where(friendships: { status: "pending" }) }, through: :inverse_friendships, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
