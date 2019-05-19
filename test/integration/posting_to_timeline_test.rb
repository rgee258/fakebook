require 'test_helper'

class PostingToTimelineTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "new post appears on timeline" do
    user = users(:tester)
    sign_in user
    get posts_path
    assert_select "h1", "Your Timeline"
    assert_select "a", "Make a new post!"
    assert_select "p", "First post"
    assert_select "p", "Third post"
    assert_select "p", "Fourth post"
    assert_select "p", "Fifth post"
    get new_post_path
    assert_select "h1", "New Post"
    assert_template 'posts/new'
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { user_id: user.id, body: "Test post" }}
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_template 'posts/index'
    assert_select "h1", "Your Timeline"
    assert_select "p", "Test post"
    assert_select "a", { count: 5, text: "View" }, "There are 5 posts with the newly added test post"
    get post_path(Post.last)
    assert_select "p", "#{user.firstname} #{user.lastname}"
    assert_select "p", "Test post"
    sign_out user

    user = users(:testwarrior)
    sign_in user
    get posts_path
    assert_select "h1", "Your Timeline"
    assert_select "p", "First post"
    assert_select "p", "Third post"
    assert_select "p", "Fourth post"
    assert_select "p", "Fifth post"
    assert_select "p", "Test post"
    assert_select "a", { count: 5, text: "View" }, "There are 5 posts with the newly added test post"
    get post_path(Post.last)
    assert_select "p", "Tester Beta"
    assert_select "p", "Test post"
  end
end
