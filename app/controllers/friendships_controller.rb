class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
    @pending_requests = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to friendships_path, notice: "Friend request sent!"
    else
      redirect_to users_path, alert: "Couldn't send friend request."
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.friend == current_user
      @friendship.update(status: "accepted")
      # Create the reverse friendship so both users see each other as friends
      Friendship.create(user: current_user, friend: @friendship.user, status: "accepted")
      redirect_to friendships_path, notice: "Friend request accepted!"
    else
      redirect_to friendships_path, alert: "Not authorized."
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.user == current_user || @friendship.friend == current_user
      # Find and destroy both friendship records
      Friendship.where(
        "(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)",
        @friendship.user_id, @friendship.friend_id, @friendship.friend_id, @friendship.user_id
      ).destroy_all
      
      redirect_to friendships_path, notice: "Friendship removed."
    else
      redirect_to friendships_path, alert: "Not authorized."
    end
  end
end