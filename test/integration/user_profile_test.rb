require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tester)
    sign_in @user
  end

  test "successfully display profile page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'div.user-photo'
    assert_select 'p', 'Tester Beta'
    assert_select 'div.user-posts'
    assert_select 'h3', 'Posts'
    assert_select 'div.user-post'
    assert_select 'div.user-post-details'
    assert_select 'div.user-post-body'
    assert_select 'div.user-post-body>p', 'First post'
    assert_select 'a', 'View'
  end

  test "successfully display profile page from root" do
    get root_path
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.user-photo'
    assert_select 'p', 'Tester Beta'
    assert_select 'div.user-posts'
    assert_select 'h3', 'Posts'
    assert_select 'div.user-post'
    assert_select 'div.user-post-details'
    assert_select 'div.user-post-body'
    assert_select 'div.user-post-body>p', 'First post'
    assert_select 'a', 'View'
  end
end
