class SessionsController < ApplicationController
  before_action :require_logout!, only: [:new, :create]
  before_action :require_login!, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    if user.nil?
      flash.now[:errors] =["Invalid username/password"]
      @user = User.new
      render :new
    else
      login_user(user)
      redirect_to tweets_url
    end
  end

  def destroy
    logout_user
    redirect_to new_session_url
  end
end
