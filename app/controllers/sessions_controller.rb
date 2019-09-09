class SessionsController < ApplicationController

  def new
    #No code needed here, just a placeholder for the 'Get' action
  end

  def create
  #Sets the session during User login 
    user = User.find_by(name: params[:name])
    if user
      user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to '/login'
    end
  end

  def destroy
    session.clear
    @_current_user = nil
    redirect_to '/'
  end


end