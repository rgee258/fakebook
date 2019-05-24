require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tester)
    sign_in @user
  end

  test "should get new" do
    get posts_new_url
    assert_response :success
    assert_select "h1", "New Post"
    assert_select "textarea"
    assert_select "input[type=submit]"
  end

  test "should get index" do
    get posts_index_url
    assert_response :success
  end

  test "successfully create post" do
    get posts_new_url
    assert_response :success
    assert_select "h1", "New Post"
    assert_select "textarea"
    assert_select "input[type=submit]"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { user_id: @user.id, body: "Test post" } }
    end
    assert_redirected_to posts_path
  end

  test "successfully create post with photo" do
    get posts_new_url
    assert_response :success
    assert_select "h1", "New Post"
    assert_select "textarea"
    assert_select "input[type=submit]"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { user_id: @user.id, body: "Test post", 
        photo_link: "https://www.whateverthisimageisitsnotreal.com" } }
    end
    assert_redirected_to posts_path
  end

  test "error rendered when creating invalid post" do
    get posts_new_url
    assert_response :success
    assert_select "h1", "New Post"
    assert_select "textarea"
    assert_select "input[type=submit]"
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { user_id: @user.id, body: "" } }
    end
    assert_template 'posts/new'
    assert_select 'div.notice'
    assert_select 'p', "Error creating post, try again."
  end

  test "successfully destroyed post" do
    get post_path(1)
    assert_response :success
    assert_select 'div.post'
    assert_select 'p.post-author', "Tester Beta"
    assert_select 'p', "First post"
    assert_difference 'Post.count', -1 do
      delete post_path(1)
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_select 'div.notice'
    assert_select 'p', "Post successfully destroyed."
  end

end
