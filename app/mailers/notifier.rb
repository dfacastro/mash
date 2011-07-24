class Notifier < ActionMailer::Base
  default from: "sMash Notifier <b.boy.souljah@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.new_account.subject
  #

  def new_account(user, remote_ip, host, protocol)
    @user = user
    @ip = remote_ip
    @host = host
    @protocol = protocol

    mail :to => user.email, :subject => 'New sMash account'
  end
  
  def account_confirmed(user, host, protocol)
    @user = user
    @host = host
    @protocol = protocol
    mail :to => user.email, :subject => 'New account confirmation'
  end
end
