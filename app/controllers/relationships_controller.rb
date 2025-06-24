# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    if @user.nil? || @user == current_user
      head :unprocessable_entity
      return
    end
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if @user.nil? || @user == current_user
      head :unprocessable_entity
      return
    end
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end
end
