class Post < ApplicationRecord

  validates :body, presence: true

  belongs_to :user
  has_many :likes, foreign_key: :liked_post_id
  has_many :liking_users, through: :likes
  has_many :comments
end
