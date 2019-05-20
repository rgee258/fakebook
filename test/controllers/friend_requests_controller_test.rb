require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @fr = FriendRequest.new(sender_id: 3, recipient_id: 1)
  end

  test "should get show with valid recipient" do
    sign_in users(:tester)
    get friend_request_path(1)
    assert_select 'h1', "New Friend Request"
    assert_select "a", "Accept"
    assert_select "a", "Decline"
    assert_template "friend_requests/show"
  end

  test "should redirect when viewing a friend request without matching recipient id" do
    sign_in users(:testwizard)
    get friend_request_path(1)
    assert_redirected_to users_path
    follow_redirect!
    assert_select "div.alert p", "You do not have permission to view this friend request."
  end

  test "successful friend request create" do
    assert_difference 'FriendRequest.count', 1 do
      @fr.save
    end
  end

  test "error renders when creating invalid friend request" do
    sign_in users(:testwarrior)
    get users_path
    assert_no_difference 'FriendRequest.count' do
      post friend_requests_path(@fr)
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'p', "Problem sending friend request, try again later."
  end

  test "successful friend request destroy" do
    @fr.save
    assert_difference 'FriendRequest.count', -1 do
      @fr.destroy
    end
  end

end
