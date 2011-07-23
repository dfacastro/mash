class Notifier < ActionMailer::Base
  default from: "sMash Notifier <b.boy.souljah@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.new_account.subject
  #
  def new_account(user, ip)
    @user = user
    @ip = ip

    mail :to => user.email, :subject => 'New account confirmation'
  end
end
