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
  has_many :friend_requests

  # Associations for friendships
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy
end
