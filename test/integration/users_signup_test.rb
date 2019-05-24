require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "unsuccessful user sign up" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { email: "testing@fakebook.com",
        first_name: "Test", last_name: "Integration", password: "short"}}
    end
    assert_template 'users/registrations/new'
    assert_select 'div#error_explanation'
  end

  test "successful user sign up" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: "testing@fakebook.com",
        first_name: "Test", last_name: "Integration", password: "wooooooo"}}
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_redirected_to user_path(User.last)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.notice'
    assert_select 'div.user-photo'
    assert_select 'p', 'Test Integration'
  end

end
