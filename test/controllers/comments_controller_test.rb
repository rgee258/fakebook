require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get new" do
    sign_in users(:tester)
    get comments_new_url
    assert_response :success
    assert_select "h1", "New Comment"
    assert_select "textarea"
    assert_select "input[type=submit]"
  end

  test "successfully created comment" do
    user = users(:tester)
    sign_in user
    get post_path(1)
    assert_select "p", "First post"
    assert_select "a", "Comment"
    get comments_new_url
    assert_template 'comments/new'
    assert_select "h1", "New Comment"
    assert_select "textarea"
    assert_select "input[type=submit]"
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { user_id: user.id, post_id: 1, body: "Test comment" } }
    end
    assert_redirected_to post_path(1)
  end

  test "successfully rendered error on invalid comment" do
    user = users(:tester)
    sign_in user
    get post_path(1)
    assert_select "p", "First post"
    assert_select "a", "Comment"
    get comments_new_url
    assert_template 'comments/new'
    assert_select "h1", "New Comment"
    assert_select "textarea"
    assert_select "input[type=submit]"
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { user_id: user.id, post_id: 1, body: "" } }
    end
    assert_template 'comments/new'
  end

  test "successfully deleted comment" do
    user = users(:testwizard)
    sign_in user
    get post_path(1)
    assert_select "p", "First post"
    assert_select "div.post-comments"
    assert_select "p", "Test comment"
    assert_select "a", "Delete"
    assert_difference "Comment.count", -1 do
      delete comment_path, params: { comment_id: 1, post_id: 1 }
    end
    assert_redirected_to post_path(1)
  end

end
