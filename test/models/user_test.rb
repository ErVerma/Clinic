require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    def setup
@user = User.new(name: "Example User", email: "user@example.com",password: "foobar", confirm_password: "foobar")
end
   test "authenticated? should return false for a user with nil digest" do
assert_not @user.authenticated?(:remember, '')end


end



