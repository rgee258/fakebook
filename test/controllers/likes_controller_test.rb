require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "error displays with invalid like" do
    sign_in users(:tester)
    assert_no_difference 'Like.count' do
      post likes_path, params: { liking_user_id: 1, post_id: 999999 }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_select 'div.alert'
    assert_select 'p', 'Trying to like that post failed, try again.'
  end

end
