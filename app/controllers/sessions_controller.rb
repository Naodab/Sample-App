# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      handle_remember_me user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def handle_remember_me(user)
    remember_me_checked? ? remember_user(user) : forget(user)
  end

  def remember_me_checked?
    params.dig(:session, :remember_me) == '1'
  end
end
