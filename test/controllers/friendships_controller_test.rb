require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @fs = Friendship.new(user_id: 1, friend_id: 2)
  end

  test "successfully create friendship" do
    # Remember that our friendships go both ways, so the assert_difference below checks for 2
    assert_difference "Friendship.count", 2 do
      @fs.save
    end
  end

  test "error displays with invalid friendship" do
    user = users(:tester)
    sign_in user
    @fs.friend_id = 999999
    assert_no_difference "Friendship.count" do
      post friendships_path(@fs)
    end
    assert_redirected_to user_notifications_path(user)
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'p', 'Something went wrong with becoming friends, try again.'
  end

  test "successfully destroy friendship" do
    @fs.save
    # Likewise, we lose two friendships when destroying
    assert_difference "Friendship.count", -2 do
      @fs.destroy
    end
  end

end
