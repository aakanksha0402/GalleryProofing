class Oauth::OauthController < ApplicationController
	layout 'oauth'
	def login	
		puts "------#{session[:is_new_redirect]}"
		if session[:is_new_redirect].present? && session[:client_id].present? && session[:client_secret].present? && session[:redirect_uri].present?
			session[:is_new_redirect] = false
		else
			render :file => "#{Rails.root}/public/404.html",  :status => 404
		end
	end



	def new
		if params[:client_id].present? && params[:client_secret].present? && params[:redirect_uri].present?
			session[:client_id]= params[:client_id]
			session[:client_secret] = params[:client_secret]
			session[:redirect_uri] = params[:redirect_uri]
			session[:is_new_redirect] = true
			redirect_to oauth_oauth_login_path
		else
			render :file => "#{Rails.root}/public/404.html",  :status => 404
		end 
	end 


	def login_attempt
		if params[:email].present? && params[:password].present?
			user = User.find_by_email(params[:email])
			if user.present?
				if user.valid_password?(params[:password])
					session[:user_id] = user.id
					session[:is_code_generated] = false
					redirect_to oauth_authorization_path(:client_id => session[:client_id] , :redirect_uri => session[:redirect_uri] , :response_type => "code")
				else
					flash[:alert] = "Invalid Password."
					render :login 
				end
			else
				flash[:alert] = "Invalid Email id."
				render :login 
			end
		else
			flash[:alert] = "Please enter the UserName and Password."
			render :login 
		end
	end


	def show_code 
		if params[:code].present? && !session[:is_code_generated].present?
			client = OAuth2::Client.new(session[:client_id], session[:client_secret], :site => 'http://192.168.1.224:3000/')
			client.auth_code.authorize_url(:redirect_uri => session[:redirect_uri])
			token = client.auth_code.get_token(params[:code], :redirect_uri => session[:redirect_uri])
			@get_token = token.token
			session[:is_code_generated] = true
			logger.warn "--------#{@get_token}"
		else
			render :file => "#{Rails.root}/public/404.html",  :status => 404
		end
		
	end
end