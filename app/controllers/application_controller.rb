class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize


  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to home_url, :alert => "Please log in"
    end
  end
end
