require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:tester)
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

end
