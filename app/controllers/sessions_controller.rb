# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember_user(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = 'Account not activated. Check your email for the activation link.'
        redirect_to root_url
      end
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
