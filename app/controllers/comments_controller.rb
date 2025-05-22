class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_back fallback_location: root_path, notice: "Comment was successfully created."
    else
      redirect_back fallback_location: root_path, alert: "Could not create comment."
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_back fallback_location: root_path, notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    redirect_back fallback_location: root_path, notice: "Comment was successfully deleted."
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :photo_id)
  end
end
