class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner = current_user

    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: 'Photo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    redirect_to user_path(current_user.username), notice: 'Photo was successfully deleted.'
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:image, :caption)
  end
end
