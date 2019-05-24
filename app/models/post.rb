class Post < ApplicationRecord

  validates :body, presence: true
  validates :photo, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'],
    size: { less_than: 2.megabytes , message: 'is too large, 2 MB max' }

  belongs_to :user
  has_many :likes, foreign_key: :liked_post_id
  has_many :liking_users, through: :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Add a optional post photo
  has_one_attached :photo
end
