class UsersController < ApplicationController

    before_action :auth_user, only: [:index]

    def index
        @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10).order("id desc")
    end

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_attr)
        if @user.save
            flash[:notice] = "注册成功，请登录"
            redirect_to new_session_path
        else
            render action: :new
        end
    end
    
    private
    def auth_user
        unless session[:user_id]
            flash[:notice] = "请登录"
            redirect_to new_session_path
        end
    end
    
    def user_attr
        params.require(:user).permit(:username, :password)
    end
    
end
