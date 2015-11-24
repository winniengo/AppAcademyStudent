class SessionsController < ApplicationController
  before_action :require_logout!, only: [:new]
  before_action :require_login!, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    if @user
      login_user(@user)
      redirect_to links_url
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    logout_user
    redirect_to new_session_url
  end
end
