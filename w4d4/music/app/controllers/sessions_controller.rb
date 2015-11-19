class SessionsController < ApplicationController
	# before_action :require_no_user!, only: [:create, :new]

	def create
		user = User.find_by_credentials(
			params[:user][:email],
			params[:user][:password])

		if user.nil?
			flash[:errors] = ["Incorrect credentials"]
			redirect_to new_session_url
		else
			login_user!(user)
			redirect_to user_url(user)
		end
	end

	def destroy
		logout_user!
		redirect_to new_session_url
	end

	def new
		@user = User.new
		render :new
	end

end
