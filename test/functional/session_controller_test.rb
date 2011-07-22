require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  
  test "should login" do
    user = users(:one)
    post :create, :username => 'dcastro', :password => 'secret'
    assert_redirected_to home_url
    assert_equal session[:user_id], user.id
  end
  
=begin
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end
=end
end
