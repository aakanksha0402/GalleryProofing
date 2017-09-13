class Api::V1::AuthController < Api::V1::BaseController 
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token 
	#respond_to :json

	def deauthorize
		if doorkeeper_token.destroy
			render_json({:stat => "success" , :msg => "Signed out successfully." }.to_json)
		end
	end

end