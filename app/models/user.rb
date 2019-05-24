class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # Uncomment below for adding omniauth with Facebook
         #,:omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :photo, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 2.megabytes , message: 'is too large, 2 MB max' }

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

  # Add a user photo
  has_one_attached :photo

  after_create :send_welcome_mail

  def send_welcome_mail
    UserMailer.welcome_mail(self).deliver
  end

=begin
  # Uncomment to add omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      #user.image = auth.info.image

      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
=end
end
