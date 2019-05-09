require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @fr = FriendRequest.create!(sender_id: 1, recipient_id: 2)
  end

  test "should get show" do
    get friend_request_path(@fr.id)
    assert_template "friend_requests/show"
  end

end
