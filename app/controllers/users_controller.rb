class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  def liked
    @user = User.find_by!(username: params.fetch(:username))
  end

  def feed
    if params[:username].present?
      @user = User.find_by!(username: params[:username])
    else
      @user = current_user
    end
  end

  def discover
    if params[:username].present?
      @user = User.find_by!(username: params[:username])
    else
      @user = current_user
    end
  end
end
