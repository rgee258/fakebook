require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome_mail" do
    user = users(:tester)
    mail = UserMailer.welcome_mail(user)
    assert_equal "Welcome to Fakebook!", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["no-reply@fakebook.com"], mail.from
    assert_match "Welcome to Fakebook!", mail.body.encoded
    assert_match "Thanks for becoming part of the Fakebook community!", mail.body.encoded
    assert_match "We look forward to the time we will share together on Fakebook.", mail.body.encoded
    assert_match "- The Fakebook Team", mail.body.encoded
  end

end
