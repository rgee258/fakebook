require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(email: "test@fakebook.com", firstname: "Test", lastname: "User", location: "Test Directory",
      age: 1010, password: "testing")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user should need email" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "user should need proper email format" do
    @user.email = "invalid"
    assert_not @user.valid?
  end

  test "user should need password" do
    @user.password = ""
    assert_not @user.valid?
  end

  test "user should need password of length 6 or greater" do
    @user.password = "notgd"
    assert_not @user.valid?
  end

  test "user should need first name" do
    @user.firstname = ""
    assert_not @user.valid?
  end

  test "user should need last name" do
    @user.lastname = ""
    assert_not @user.valid?
  end

  test "user should need location" do
    @user.location = ""
    assert_not @user.valid?
  end

  test "user should need age" do
    @user.age = ""
    assert_not @user.valid?
  end

  test "user email should be unique" do
    # Tester email is already present in fixtures
    @user.email = "tester@fakebook.com"
    assert_not @user.valid?
  end

end
