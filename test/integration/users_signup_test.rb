require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "unsuccessful user sign up" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { email: "testing@fakebook.com",
        firstname: "Test", lastname: "Integration", age: 0, location: "Unknown", 
        password: "short" }}
    end
    assert_template 'users/registrations/new'
    assert_select 'div#error_explanation'
  end

  test "successful user sign up" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: "testing@fakebook.com",
        firstname: "Test", lastname: "Integration", age: 0, location: "Unknown", 
        password: "wooooooo" }}
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_redirected_to user_path(User.last)
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.notice'
  end

end
