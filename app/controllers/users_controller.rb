class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def show
  	if session[:current_user_id]
  		@reservations = Reservation.all
  		@user = User.find_by(id: params[:id])
  	else
  		redirect_to '/'
  	end
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user
    	# Sets the User session and redirects to the User's show page
    	session[:current_user_id] = @user.id
    	redirect_to user_path(@user)
    else
    	render :new
    end
  end

  def edit
	@user = User.find_by(id: params[:id])
  end

  def update
	@user = User.find_by(id: params[:id])
	@user.update(name: user_params[:name], email: user_params[:email], telephone: user_params[:telephone], password: user_params[:password], password_confirmation: user_params[:password_confirmation])
	redirect_to user_path(@user)
  end

  def destroy
  	User.find_by(id: params[:id]).destroy
  	redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :telephone, :password, :password_confirmation)
  end

end