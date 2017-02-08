class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user, :send_to_login_unless_logged_in
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

 def send_to_login_unless_logged_in
    if @current_user.nil?
      redirect_to login_path, notice: "You must login before proceeding"
    end
  end

end

