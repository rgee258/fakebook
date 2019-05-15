require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @fs = Friendship.new(user_id: 1, friend_id: 2)
  end

  test "successfully create friendship" do
    # Remember that our friendships go both ways, so the assert_difference below checks for 2
    assert_difference "Friendship.count", 2 do
      @fs.save
    end
  end

  test "successfully destroy friendship" do
    @fs.save
    # Likewise, we lose two friendships when destroying
    assert_difference "Friendship.count", -2 do
      @fs.destroy
    end
  end

end
