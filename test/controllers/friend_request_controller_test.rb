require 'test_helper'

class FriendRequestControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get friend_request_show_url
    assert_response :success
  end

end
