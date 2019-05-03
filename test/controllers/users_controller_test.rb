require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in users(:tester)
    get users_url
    assert_response :success
  end

  test "should get show using preset admin user" do
    sign_in users(:tester)
    get user_url(1)
    assert_response :success
  end

end
