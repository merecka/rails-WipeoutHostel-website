class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :current_user

  def index
  	render :index
  end

  def current_user
  	@logged_in_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

end
