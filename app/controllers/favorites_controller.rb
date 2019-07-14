class FavoritesController < ApplicationController
    def create
        favorite = current_user.favorites.build(photo_id: params[:photo_id])
        favorite.save
        redirect_to photos_path
    end
    
    def destroy
        favorite = Favorite.find_by(photo_id: params[:photo_id], user_id: current_user.id)
        favorite.destroy
        redirect_to photos_path
    end
    
    def index
        @user = current_user
        @favorites = Favorite.where(user_id: @user.id).all
    end
end
