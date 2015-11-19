class UsersController < ApplicationController
	# before_action :require_no_user!
	
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.create(user_params)

		if @user.save
			login_user!(@user)
			redirect_to user_url(@user)
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def show
		@user = current_user
		render :show
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
