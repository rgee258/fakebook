require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase

  def setup
    @fr = FriendRequest.new(recipient_id: 1, sender_id: 2)
  end
  
  test "successfully created friend request" do
    assert @fr.valid?
  end

  test "unsuccessful friend request with missing recipient id" do
    @fr.recipient_id = nil
    assert_not @fr.valid?
  end

  test "unsuccessful friend request with missing sender id" do
    @fr.sender_id = nil
    assert_not @fr.valid?
  end

  test "unsuccessful friend request with unknown recipient id" do
    @fr.recipient_id = 999999999
    assert_not @fr.valid?
  end

  test "unsuccessful friend request with unknown sender id" do
    @fr.sender_id = 999999999
    assert_not @fr.valid?
  end
end
