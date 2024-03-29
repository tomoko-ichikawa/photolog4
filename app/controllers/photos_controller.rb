class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :ensure_correct_user]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
     @user = @photo.user
     @comments = @photo.comments
     @comment = @photo.comments.build
  end

  # GET /photos/new
  def new
      if params[:back]
          @photo = Photo.new(photo_params)
      else
          @photo = current_user.photos.build
          @user = @photo.user
      end
  end
  
  # GET /photos/1/edit
  def edit
      @user = @photo.user
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id

    respond_to do |format|
      if @photo.save
        ContactMailer.send_when_create(@photo).deliver
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
      @user = @photo.user
      if @photo.update(photo_params)
          redirect_to "/users/#{@user.id}",notice:"編集しました！"
      else
          render 'edit'
      end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
      @user = @photo.user
      @photo.destroy
      respond_to do |format|
          format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
          format.json { head :no_content }
      end
  end
  
  def confirm
      @photo = current_user.photos.build(photo_params)
      @user = @photo.user
      render :new if @photo.invalid?
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_photo
      @photo = Photo.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
      params.require(:photo).permit(:image, :image_cache, :caption)
  end
    
  def ensure_correct_user
        @photo = Photo.find(params[:id])
    if current_user.id != @photo.user_id
            flash[:notice] = "権限がありません"
            redirect_to photos_path
    end
 end
end
