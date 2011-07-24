class SessionController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      if user.confirmed
        session[:user_id] = user.id
        redirect_to home_url
      else
        redirect_to home_url, :alert => 'This account has yet to be confirmed. Please check your e-mail.'
      end
    else
      redirect_to home_url, :alert => 'Invalid user/password combination.'
    end    
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_url
  end

end
