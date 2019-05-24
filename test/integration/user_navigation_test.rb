require 'test_helper'

class UserNavigationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tester)
    sign_in @user
  end

  test 'navigation bar displays successfully' do
    get user_path(@user)
    assert_select('ul#navigation')
    assert_select('div.nav-greeting')
    assert_select('div.nav-greeting>li>p.current-user-name', 'Tester Beta')
    assert_select('div.nav-links>li>a', 'Timeline')
    assert_select('div.nav-links>li>a[href=?]', posts_path)
    assert_select('div.nav-links>li>a', 'Notifications (1)')
    assert_select('div.nav-links>li>a[href=?]', user_notifications_path(@user))
    assert_select('div.nav-links>li>a', 'Profile')
    assert_select('div.nav-links>li>a[href=?]', user_path(@user))
    assert_select('div.nav-links>li>a', 'All Users')
    assert_select('div.nav-links>li>a[href=?]', users_path)
    assert_select('div.nav-links>li>a', 'Account')
    assert_select('div.nav-links>li>a[href=?]', edit_user_registration_path)
    assert_select('div.nav-links>li>a', 'Logout')
    assert_select('div.nav-links>li>a[href=?]', logout_path)
    # Make sure the navigation is consistent on a different page
    get posts_path
    assert_select('ul#navigation')
    assert_select('div.nav-greeting')
    assert_select('div.nav-greeting>li>p.current-user-name', 'Tester Beta')
    assert_select('div.nav-links>li>a', 'Timeline')
    assert_select('div.nav-links>li>a[href=?]', posts_path)
    assert_select('div.nav-links>li>a', 'Notifications (1)')
    assert_select('div.nav-links>li>a[href=?]', user_notifications_path(@user))
    assert_select('div.nav-links>li>a', 'Profile')
    assert_select('div.nav-links>li>a[href=?]', user_path(@user))
    assert_select('div.nav-links>li>a', 'All Users')
    assert_select('div.nav-links>li>a[href=?]', users_path)
    assert_select('div.nav-links>li>a', 'Account')
    assert_select('div.nav-links>li>a[href=?]', edit_user_registration_path)
    assert_select('div.nav-links>li>a', 'Logout')
    assert_select('div.nav-links>li>a[href=?]', logout_path)
  end
end
