class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @users = User.all
    end
    
    def show
        @users = User.all
        @user = User.find(params[:id])
        @photos = @user.photos
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
