require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "forgot" do
    mail = UserMailer.forgot
    assert_equal "Forgot", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
    

   test "account_activation" domail = UserMailer.account_activation
   assert_equal "Account activation", mail.subject
  assert_equal ["to@example.org"], mail.to
   assert_equal ["from@example.com"], mail.from
   assert_match "Hi", mail.body.encoded
  end

      test "account_activation" do
user = users(:michael) user.activation_token = User.new_token
mail = UserMailer.account_activation(user)
assert_equal "Account activation", mail.subject
assert_equal [user.email], mail.to
assert_equal ["noreply@example.com"], mail.from
assert_match user.name, mail.body.encoded
assert_match user.activation_token, mail.body.encoded
assert_match CGI.escape(user.email), mail.body.encoded
 end



end
