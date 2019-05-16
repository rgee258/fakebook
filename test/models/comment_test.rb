require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = Comment.new(user_id: 1, post_id: 1, body: "Comment")
  end

  test "successful valid comment" do
    assert @comment.valid?
  end

  test "invalid comment with unknown user_id" do
    @comment.user_id = 999999
    assert_not @comment.valid?
  end

  test "invalid comment with unknown post_id" do
    @comment.post_id = 999999
    assert_not @comment.valid?
  end

  test "invalid comment with missing body" do
    @comment.body = ""
    assert_not @comment.valid?
  end
end
