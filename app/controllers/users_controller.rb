class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
      @existing_friendship = Friendship.find_by(user: current_user, friend: @user) || 
                Friendship.find_by(user: @user, friend: current_user)
  end
end