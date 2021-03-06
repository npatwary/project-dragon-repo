class UsersController < ApplicationController

  before_action :logged_in_user, only: [:show]
  before_action :correct_user,   only: [:show]
  
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end


	def create
		@user = User.new(params.require(:user).permit(:user_name,:email,:password,:password_confirmation))
  		if @user.save
  			log_in @user
  			flash[:success] = "Welcome to Dungeons and Dragons !"
  			redirect_to user_path(@user)
  		else
  			render 'new'
  		end
	end
	
	def index
		@users = User.all
	end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
