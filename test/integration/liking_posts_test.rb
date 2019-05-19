require 'test_helper'

class LikingPostsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "first user successfully liked the second post" do
    user = users(:tester)
    sign_in user
    get post_path(2)
    assert_select 'div.post'
    assert_select 'p', 'Second post'
    assert_select 'p', '0 likes'
    assert_select 'a', 'Like'
    assert_difference 'Like.count', 1 do
      post likes_path, params: { liking_user_id: 1, post_id: 2 }
    end
    assert_redirected_to post_path(2)
    follow_redirect!
    assert_select 'div.post'
    assert_select 'p', 'Second post'
    assert_select 'p', '1 likes'
    assert_select 'a', { count: 0, text: "Like" }, 'No likes here'
    assert_select 'a', 'Unlike'
  end

  test "second user successfully unliked the first post" do
    user = users(:testwizard)
    sign_in user
    get post_path(1)
    assert_select 'div.post'
    assert_select 'p', 'First post'
    assert_select 'p', '1 likes'
    assert_select 'a', 'Unlike'
    assert_difference 'Like.count', -1 do
      delete like_path, params: { like_id: 1, post_id: 1 }
    end
    assert_redirected_to post_path(1)
    follow_redirect!
    assert_select 'div.post'
    assert_select 'p', 'First post'
    assert_select 'p', '0 likes'
    assert_select 'a', { count: 0, text: "Unlike" }, 'No unlikes here'
    assert_select 'a', 'Like'
  end
end
