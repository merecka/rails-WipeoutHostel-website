class ReservationsController < ApplicationController

  def index
    @user = current_user
    if @user.admin
      # provide a list of users and rooms to the view for the filter control - only for admins
      @users = User.all
      @rooms = Room.all

      # filter the @reservations list based on user input
      if !params[:user_id].blank? && !params[:room_id].blank?
        @user = User.by_user(params[:user_id])
        @room = Room.by_room(params[:room_id])
        @reservations = Reservation.by_reservation_user_and_room(@user.ids, @room.ids)
      elsif !params[:user_id].blank?
        @user = User.by_user(params[:user_id])
        @reservations = Reservation.by_reservation_user(@user.ids)
      elsif !params[:room_id].blank?
        @room = Room.by_room(params[:room_id])
        @reservations = Reservation.by_reservation_room(@room.ids)
      else
    	  @reservations = Reservation.all
      end
    else
      # displays all the User's reservations for a non-admin User
      @reservations = User.find_by(id: @user.id).reservations
    end

  end

  def show
  	if session[:current_user_id]
      @user = current_user
  		@reservation = Reservation.find_by(id: params[:id])
  	else
  		redirect_to '/login'
  	end
  end

  def new
  	@reservation = Reservation.new
    @user = current_user
    # Sets the room based on the room#show where 'Reserve This Room' link was clicked.
    @room = Room.find_by(id: params[:room][:room_id])
  end

  def create
    #Creates initial Reservation from Rooms#Show view page form
    @reservation = Reservation.create(reservation_params)
    @room = Room.find_by(id: params[:reservation][:room_id])
    @user = User.find_by(id: params[:reservation][:user_id])
    # if @reservation.guests == nil || @reservation.check_in == nil || @reservation.check_out == nil
    # Renders the edit Reservation form for the user to finish filling out the Reservation details
    render :edit
  end

  def edit
    #Only Admins can edit Reservations
      @user = current_user
	    @reservation = Reservation.find_by(id: params[:id])
      @room = @reservation.room
      render :edit
  end

  def update
  	@reservation = Reservation.find_by(id: params[:id])
    @room = Room.find_by(id: reservation_params[:room_id])
  	@reservation.update(user_id: reservation_params[:user_id], room_id: reservation_params[:room_id], guests: reservation_params[:guests], check_in: reservation_params[:check_in], check_out: reservation_params[:check_out], discount: reservation_params[:discount])
    if @reservation.check_in != nil && @reservation.check_out != nil
      @reservation.update(total: helpers.total_cost(@reservation))
      if @reservation.valid?
        flash[:success] = "You have sucessfully made your Reservation!"
        redirect_to reservation_path(@reservation)
      else
        flash[:error] = "Please check your input data and try again."
        redirect_to edit_reservation_path(@reservation)
      end
    else
      flash[:error] = "Please input a valid Check-In and Check-Out date."
      render :edit
    end
  end

  def destroy
  	Reservation.find_by(id: params[:id]).destroy
  	redirect_to user_path(current_user)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :guests, :check_in, :check_out, :discount, :total)
  end

end