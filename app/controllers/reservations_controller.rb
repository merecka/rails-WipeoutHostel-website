class ReservationsController < ApplicationController

  def index
  	@reservations = Reservation.all
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
    @reservation = Reservation.create(reservation_params)
    @room = Room.find_by(id: params[:reservation][:room_id])
    @user = User.find_by(id: params[:reservation][:user_id])
    if @reservation.guests == nil || @reservation.check_in == nil || @reservation.check_out == nil
      # Renders the edit Reservation form if any of the above attributes are nil
      render :edit
    else
      # Redirects to the Reservations's show page
      redirect_to reservation_path(@reservation)
    end
  end

  def edit
    if current_user.admin == true
	     @reservation = Reservation.find_by(id: params[:id])
    else
      redirect_to reservations_path
    end
  end

  def update
  	@reservation = Reservation.find_by(id: params[:id])
    total_cost = (@reservation.room.cost * @reservation.guests)
  	@reservation.update(user_id: reservation_params[:user_id], room_id: reservation_params[:room_id], guests: reservation_params[:guests], check_in: reservation_params[:check_in], check_out: reservation_params[:check_out], discount: reservation_params[:discount], total: total_cost)
  	redirect_to reservation_path(@reservation)
  end

  def destroy
  	Reservation.find_by(id: params[:id]).destroy
  	redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :guests, :check_in, :check_out, :discount, :total)
  end

end