require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should redirect to sign in without login when requesting index" do
    get users_url
    assert_redirected_to new_user_session_path
  end

  test "should get index with login" do
    sign_in users(:tester)
    get users_url
    assert_response :success
  end

  test "should redirect to sign in without login when requesting show for user 1" do
    get user_url(1)
    assert_redirected_to new_user_session_path
  end

  test "should get show using preset admin user with login" do
    sign_in users(:tester)
    get user_url(1)
    assert_response :success
  end

end
