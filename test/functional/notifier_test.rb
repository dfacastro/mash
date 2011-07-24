require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "new_account" do
    user = users(:two)
    mail = Notifier.new_account(user, '192.168.1.100', 'localhost:3000', 'http://')
    assert_equal "New sMash account", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["b.boy.souljah@gmail.com"], mail.from
    assert_match "Hey there!", mail.body.encoded
  end

end
