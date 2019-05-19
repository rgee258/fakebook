require 'test_helper'

class CommentingOnPostsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "successfully create a comment on the second post" do
    user = users(:tester)
    sign_in user
    get post_path(2)
    assert_select 'div.post'
    assert_select 'p', 'Second post'
    assert_select 'a', 'Comment'
    get new_comment_path
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { user_id: 1, post_id: 2, body: "Test comment!" } }
    end
    assert_redirected_to post_path(2)
    follow_redirect!
    assert_select 'div.post'
    assert_select 'p', 'Second post'
    assert_select 'div.comment'
    assert_select 'p', 'Test comment!'
    assert_select 'a', 'Delete'
  end

  test "successfully destroy an existing comment on the first post" do
    user = users(:testwizard)
    sign_in user
    get post_path(1)
    assert_select 'div.post'
    assert_select 'p', 'First post'
    assert_select 'div.comment'
    assert_select 'p', 'Test comment'
    assert_select 'a', 'Delete'
    assert_difference 'Comment.count', -1 do
      delete comment_path, params: { comment_id: 1, post_id: 1 }
    end
    assert_redirected_to post_path(1)
    follow_redirect!
    assert_select 'div.post'
    assert_select 'p', 'First post'
    assert_select 'p', { count: 0, text: 'Test comment' }, "No comments remaining"
    assert_select 'a', { count: 0, text: 'Delete' }, "No comment delete options remaining"
  end

  test "no delete option for comments not belonging to current user" do
    user = users(:testwarrior)
    sign_in user
    get post_path(1)
    assert_select 'div.post'
    assert_select 'p', 'First post'
    assert_select 'div.comment'
    assert_select 'p', 'Test comment'
    assert_select 'a', { count: 0, text: 'Delete' }, "No comment delete options remaining"
  end
end
