class AuthenticationController < ApplicationController
  before_filter :require_login, :only => [:logout]

  def login
    if session[:user_id]
      redirect_to :root
    end
  end

  def authenticate
    username = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by_username(username)
    if user && user.password == password
      session[:user_id] = user.id
      flash[:notice] = 'Successfully logged in.'
      redirect_to :root
    else
      flash[:error] = 'Please enter correct username and password.'
      render :action => "login"
    end
  end

  def logout
    #session[:user_id] = nil
    reset_session
    flash[:notice] = 'Successfully logged out.'
    redirect_to login_path
  end

  def signup
    @user = User.new
  end

  def create_user
    @user = User.new(params[:user])

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Successfully logged in.'
      redirect_to :root
    else
      render :action => "signup"
    end
  end

end