class RoomsController < ApplicationController
  before_action :current_room, only: [:show, :edit, :update]

  def index
  	@rooms = Room.all
  end

  def show
  	if session[:current_user_id]
      @reservation = Reservation.new
      @rooms = Room.all
  	else
  		redirect_to '/login'
  	end
  end

  def new
  	@room = Room.new
  end

  def create
    @room = Room.create(room_params)
    if @room
    	# Redirects to the Rooms's show page
    	redirect_to room_path(@room)
    else
    	render :new
    end
  end

  def edit
    #Only Admins can edit Rooms
    if current_user.admin
    else
      redirect_to rooms_path
    end
  end

  def update
  	@room.update(name: room_params[:name], occupancy: room_params[:occupancy], cost: room_params[:cost])
  	redirect_to room_path(@room)
  end

  def destroy
  	Room.find_by(id: params[:id]).destroy
  	redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit(:name, :occupancy, :cost)
  end

  def current_room
    @room = Room.find_by(id: params[:id])
  end

end