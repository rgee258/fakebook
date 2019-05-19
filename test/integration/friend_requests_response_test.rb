require 'test_helper'

class FriendRequestsResponseTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tester)
    sign_in @user
  end

  test "successful first friend request accept" do
    get root_path
    assert_select "a", "Notifications (1)"
    get user_notifications_path(@user)
    assert_select "h1", "Notifications"
    assert_select "div.user-notification"
    assert_select "p", "New friend request from Test."
    assert_select "a", "View"
    get friend_request_path(1)
    assert_template "friend_requests/show"
    assert_select "h1", "New Friend Request"
    assert_select "a", "Accept"
    original_fr_count = FriendRequest.count
    # Remember that our friendships go both ways, so the assert_difference below checks for 2
    assert_difference 'Friendship.count', 2 do
      post friendships_path, params: { friend_id: 2, request_id: 1 }
    end
    assert_not_same original_fr_count, "FriendRequest.count"
    assert_redirected_to user_notifications_path(@user)
    follow_redirect!
    assert_select "a", "Notifications (0)"
  end

  test "successful first friend request decline" do
    get root_path
    assert_select "a", "Notifications (1)"
    get user_notifications_path(@user)
    assert_select "h1", "Notifications"
    assert_select "div.user-notification"
    assert_select "p", "New friend request from Test."
    assert_select "a", "View"
    get friend_request_path(1)
    assert_template "friend_requests/show"
    assert_select "a", "Decline"
    assert_difference 'FriendRequest.count', -1 do
      delete friend_request_path, params: { id: 1 }
    end
    assert_redirected_to user_notifications_path(@user)
    follow_redirect!
    assert_select "a", "Notifications (0)"
  end
end
