class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    # user = User.authenticate(params[:username], params[:password])
    if user# && user.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Logged in!"
    else
      flash.now.alert = "Username and/or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end
