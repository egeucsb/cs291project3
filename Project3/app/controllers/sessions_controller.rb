class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    # Renders the login form
  end

  def create
    username = params[:username].strip
    if username.blank?
      flash[:alert] = "Username cannot be blank."
      redirect_to login_path
      return
    end

    @user = User.find_by(username: username)

    if @user
      # Existing user, log them in
      session[:user_id] = @user.id
      flash[:notice] = "Logged in successfully."
    else
      # Create a new user and log them in
      @user = User.create(username: username)
      if @user.persisted?
        session[:user_id] = @user.id
        flash[:notice] = "Account created and logged in successfully."
      else
        flash[:alert] = "Failed to create user: #{@user.errors.full_messages.join(', ')}"
        redirect_to login_path
        return
      end
    end

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to login_path
  end
end
