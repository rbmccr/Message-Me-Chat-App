class SessionsController < ApplicationController

    def new

    end

    def create
				user = User.find_by(username: params[:session][:username])
				if user && user.authenticate(params[:session][:password])
					session[:user_id] = user.id
					flash[:success] = "You've successfully logged in as #{user.username}"
					redirect_to root_path
				else
					flash.now[:error] = "There was a problem logging in. Please try again."
					render 'new'
				end
		end
		
		def destroy
			session[:user_id] = nil
			flash[:success] = "You have successfully logged out."
			redirect_to login_path
		end

end
