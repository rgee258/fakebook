require 'test_helper'

class UsersDirectoryTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test 'user directory displays with according friend statuses' do
    user = users(:tester)
    sign_in user
    get users_path
    assert_template 'users/index'
    assert_select 'h1', 'User Directory'
    assert_select 'a', 'Test Wizard'
    assert_select 'p', 'Pending'
    assert_select 'a', 'Test Warrior'
    assert_select 'a', 'Unfriend'
    assert_select 'a', 'Test Ranger'
    assert_select 'a', 'Add Friend'
  end

  test 'accepting a pending friend request updates user directory' do
    user = users(:tester)
    sign_in user
    get user_notifications_path(user)
    assert_template 'users/notifications'
    assert_select 'h1', 'Notifications'
    assert_select 'p', 'New friend request from Test.'
    assert_select 'a', 'View'
    get friend_request_path(1)
    assert_template 'friend_requests/show'
    assert_select 'h1', 'New Friend Request'
    assert_select 'a', 'Accept'
    assert_difference 'Friendship.count', 2 do
      post friendships_path, params: { friend_id: 2, request_id: 1}
    end
    assert_redirected_to user_notifications_path(user)
    follow_redirect!
    assert_select 'div.notice', "Friend request accepted."
    get users_path
    assert_select 'p', { count: 0, text: 'Pending'}, "No more pending friend requests for Tester"
    assert_select 'a', { count: 2, text: 'Unfriend'}, "Tester now has two friends"
  end

  test 'declining a pending friend request updates user directory' do
    user = users(:tester)
    sign_in user
    get user_notifications_path(user)
    assert_template 'users/notifications'
    assert_select 'h1', 'Notifications'
    assert_select 'p', 'New friend request from Test.'
    assert_select 'a', 'View'
    get friend_request_path(1)
    assert_template 'friend_requests/show'
    assert_select 'h1', 'New Friend Request'
    assert_select 'a', 'Decline'
    assert_difference 'FriendRequest.count', -1 do
      delete friend_request_path(1)
    end
    assert_redirected_to user_notifications_path(user)
    follow_redirect!
    assert_select 'div.notice', "Friend request declined."
    get users_path
    assert_select 'p', { count: 0, text: 'Pending'}, "No more pending friend requests for Tester"
    assert_select 'a', { count: 2, text: 'Add Friend'}, "Tester can add two friends"
  end

  test 'removing a friend updates user directory' do
    user = users(:tester)
    sign_in user
    get users_path
    assert_template 'users/index'
    assert_select 'a', 'Test Warrior'
    assert_select 'a', 'Unfriend'
    assert_difference 'Friendship.count', -2 do
      delete friendship_path(1)
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_template 'users/index'
    assert_select 'div.notice', "Friend removed."
    assert_select 'a', { count: 2, text: 'Add Friend'}, "Tester has no more friends"
  end

  test 'sending a new friend request updates user directory' do
    user = users(:tester)
    sign_in user
    get users_path
    assert_template 'users/index'
    assert_select 'h1', 'User Directory'
    assert_select 'a', 'Test Ranger'
    assert_select 'a', 'Add Friend'
    assert_difference 'FriendRequest.count', 1 do
      post friend_requests_path, params: { recipient_id: 4 }
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_template 'users/index'
    assert_select 'div.notice', "Friend request sent!"
    assert_select 'p', { count: 2, text: 'Pending'}, "Two pending friend requests for Tester"
    assert_select 'a', { count: 0, text: 'Add Friend'}, "Tester does not have anymore friends to add"
    sign_out(user)

    user = users(:testranger)
    sign_in user
    get users_path
    assert_select 'a', 'Notifications (1)'
    get user_notifications_path(user)
    assert_template 'users/notifications'
    assert_select 'h1', 'Notifications'
    assert_select 'p', 'New friend request from Tester.'
    assert_select 'a', 'View'
    get friend_request_path(FriendRequest.last)
    assert_template 'friend_requests/show'
    assert_select 'h1', 'New Friend Request'
  end

end
