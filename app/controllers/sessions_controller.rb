class SessionsController < ApplicationController
	skip_before_action :send_to_login_unless_logged_in
	before_action :redirect_to_user_index_if_logged_in, only: :new

  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	respond_to do |format|
	  	if user && user.authenticate(params[:password])
	  		session[:user_id] = user.id  ## logged in!
	  		format.html { redirect_to user_path(user.id), notice: "#{user.fname} #{user.lname} is now logged in"}
	  		# do something that indicates that login was sucessful
	  		# redirect to posts index

	  	else
	  		@error = "Your email and password combination is not valid"
	  		format.html { render :new}
	  		# login not successful
	  		# render login page and show error
	  	end
	  end
	end

	def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to login_path, notice: 'You have been logged out, you loser!'}
    end
  end

  def redirect_to_user_index_if_logged_in
  	redirect_to user_path(@current_user.id) if @current_user.present?
  end
end

