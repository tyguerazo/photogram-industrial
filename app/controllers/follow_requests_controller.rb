class FollowRequestsController < ApplicationController
  before_action :set_follow_request, only: %i[ show edit update destroy accept reject ]

  def index
    @follow_requests = FollowRequest.all
  end

  def show
  end

  def new
    @follow_request = FollowRequest.new
  end

  def edit
  end

  def create
    @follow_request = FollowRequest.new(follow_request_params)
    @follow_request.sender = current_user
    @follow_request.status = "pending"

    if @follow_request.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path, alert: 'Could not send follow request.')
    end
  end

  def update
    if @follow_request.update(follow_request_params)
      redirect_to @follow_request, notice: "Follow request was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @follow_request.destroy!
    redirect_back(fallback_location: root_path)
  end

  def accept
    @follow_request.update!(status: "accepted")
    redirect_back(fallback_location: root_path)
  end

  def reject
    @follow_request.update!(status: "rejected")
    redirect_back(fallback_location: root_path)
  end

  private

  def set_follow_request
    @follow_request = FollowRequest.find(params[:id])
  end

  def follow_request_params
    params.require(:follow_request).permit(:recipient_id)
  end
end
