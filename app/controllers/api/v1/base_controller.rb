class Api::V1::BaseController < ActionController::Base

	rescue_from ActiveRecord::RecordNotFound, :with => :bad_record
	skip_before_filter :verify_authenticity_token , :if => Proc.new {|c| c.request.format == "application/json"}
	after_filter :set_access_control_headers
	
	protected

	def authenticate_user_with_access_token
    	@current_user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    	unless @current_user.present?
   			render_json({:result => {:messages => "Please enter the correct access token"}}.to_json)
   	 	end
	end

	def render_json(json)
		callback = params[:callback]
		response  = begin
		  if callback
		  	"#{callback}(#{json});"
		  else
		  	json
		  end	
		end
		render({:content_type => :js ,:text => response})
	end

	def bad_record 
		render_json({:result => {:messages => "No record found" ,:rstatus => 0 , :errorcode => 404}}.to_json)
	end

	def parameter_errors
		render_json({:result => {:messages => "You have supplied invalid paramater list." ,:rstatus => 0 , :errorcode => 500}}.to_json)
	end

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = "*"
		headers['Access-Control-Request-Method'] = "*"
	end
end 