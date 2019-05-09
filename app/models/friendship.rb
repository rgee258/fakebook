# Setting up this model and association was done following this guide here:
# https://collectiveidea.com/blog/archives/2015/07/30/bi-directional-and-self-referential-associations-in-rails

class Friendship < ApplicationRecord

  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_match_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    self.class.where(inverse_match_options)
  end

  def inverse_match_options
    { friend_id: user_id, user_id: friend_id}
  end
end