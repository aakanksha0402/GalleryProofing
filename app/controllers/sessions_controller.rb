class SessionsController < Devise::SessionsController

  	def new
    	session[:return_to] = params[:return_to]  if params[:return_to]
    	puts "----------session-------#{session[:return_to]}----"
    	super
  	end

	# POST /resource/sign_in
	def create
	  	self.resource = warden.authenticate!(auth_options)
	    set_flash_message(:notice, :signed_in) if is_navigational_format?
	    sign_in(resource_name, resource)
	    if !session[:return_to].blank?
	    	puts "redirect to return_to"
	      	redirect_to session[:return_to]
	      	session[:return_to] = nil
	    else
	    	puts "redirect_to normal"
	     	respond_with resource, :location => after_sign_in_path_for(resource)
	    end
	end

  def after_sign_in_path_for(resource)
    session[:user_id] = resource.id
    @user = User.find(session[:user_id])
    if @user.firstname == nil || @user.lastname == nil
      session[:modal] = true
    end
    root_path
  end
end
