class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image 

  validate :must_have_content

  private

  def must_have_content
    if body.blank? && !image.attached?
      errors.add(:base, "Post must have either text or an image")
    end
  end
end