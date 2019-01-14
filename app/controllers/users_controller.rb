class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update]
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new user_params
        if @user.save
            flash[:primary] = "Welcome, #{@user.first_name}!"
            session[:user_id] = @user.id
            redirect_to ideas_path
        else
           render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(
            :first_name, :last_name, :email, :password, :password_confirmation)
    end

end
