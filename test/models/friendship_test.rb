require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
    @fs = Friendship.new(user_id: 1, friend_id: 2)
  end

  test "successfully created friendship" do
    assert @fs.valid?
  end

  test "unsuccessful friend request with nil user id" do
    @fs.user_id = nil
    assert_not @fs.valid?
  end

  test "unsuccessful friend request with nil friend id" do
    @fs.friend_id = nil
    assert_not @fs.valid?
  end

  test "unsuccessful friend request with nonexistent user id" do
    @fs.user_id = 999999999
    assert_not @fs.valid?
  end

  test "unsuccessful friend request with nonexistent friend id" do
    @fs.friend_id = 999999999
    assert_not @fs.valid?
  end

end
