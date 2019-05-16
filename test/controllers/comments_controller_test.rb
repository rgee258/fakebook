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

end
