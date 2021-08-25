class SessionsController < ApplicationController
    
    def new
        @errors = []
    end

    def create
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            flash[:message] = "You are successfully logged in!"
            redirect_to user_path(@user)
        elsif @user
            @errors = ["Invalid password"]
            render :new
        else
            @errors = ["invalid username"]
            render :new
        end
    end

    def destroy
        session.clear
        flash[:message] = "You are successfully logged out!"
        redirect_to signup_path
    end
    
end