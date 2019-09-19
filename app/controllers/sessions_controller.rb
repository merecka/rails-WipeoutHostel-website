class SessionsController < ApplicationController

  def new
    #No code needed here, just a placeholder for the 'Get' action
  end

  def create
    if auth != nil
    #Logins or (or creates) a User from Facebook login via Omniauth
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
        u.password = "password"
        u.password_confirmation = "password"
      end
      render :"users/edit"
    else

    #Sets the session during User manual login 
      user = User.find_by(id: params[:user][:id])
      if user
        user.authenticate(params[:password])
        session[:current_user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to '/login'
      end
    end
  end

  def destroy
    session.clear
    @_current_user = nil
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end