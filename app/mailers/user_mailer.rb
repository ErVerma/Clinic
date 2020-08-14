class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot.subject
  #
  def forgot(user)
    @user = user

    mail to: @user.email, subject: "Login Credentials for #{@user.name}"
  end
    def confirmation(user)
    @user = user

    mail to: @user.phone, subject: "Appointments Detail for #{@user.p_name}"
  end
  

  def account_activation(user)
   @user = user
   mail to: user.email, subject: "Account activation"
   end


end
