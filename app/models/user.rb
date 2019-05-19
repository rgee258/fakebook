class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :location, presence: true
  validates :age, presence: true

  # Associations for friend requests
  has_many :friend_requests, foreign_key: :sender_id, dependent: :destroy

  # Associations for friendships
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy

  # Associations for posts
  has_many :posts, dependent: :destroy

  # Associations for likes
  has_many :likes, foreign_key: :liking_user_id
  has_many :liked_posts, through: :likes, dependent: :destroy

  # Associations for comments
  has_many :comments, dependent: :destroy
end
