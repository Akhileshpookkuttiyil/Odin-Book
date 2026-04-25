class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :status, inclusion: { in: %w[pending accepted rejected] }
  validates :user_id, uniqueness: { scope: :friend_id }
end
