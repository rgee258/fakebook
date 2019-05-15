require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(user_id: 1, body: "Test post")
  end

  test "successfully created post" do
    assert @post.valid?
  end

  test "post must have a valid user id" do
    @post.user_id = 999999
    assert_not @post.valid?
  end

  test "post must have a non-nil body" do
    @post.body = nil
    assert_not @post.valid?
  end

  test "post must have a nonempty body" do
    @post.body = ""
    assert_not @post.valid?
  end
end
