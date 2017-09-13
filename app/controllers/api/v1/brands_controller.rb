class Api::V1::BrandsController < Api::V1::BaseController 
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token 
	#respond_to :json

	def get_list
		@brands = @current_user.brands.all
		if !@brands.present?
			render_json({:stat => "fail" ,:code => 400 , :msg => "Brand is not available." }.to_json)
		end
	end

	def create 
		if params.present?
			if params[:address][:country].present?
				@country = Country.find_by(:name => params[:address][:country].capitalize)
				if @country.present?
					@brand = @current_user.brands.build(:brand_name => params[:name] ,:email => params[:email] , :phone_number => params[:phone] ,:website_url => params[:website],:address1 => params[:address][:address_1] ,:address2 => params[:address][:address_2] ,:city  => params[:address][:city],:brand_country => params[:address][:country],:pincode => params[:address][:zip_postal])
				 	@brand.default = @current_user.brands.count != 0 ? false : true  
				 	if !@brand.save	
						render_json({:stat => "fail" ,:code => 400, :msg => @brand.errors.full_messages}.to_json)
				 	end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid Country name."}.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the Country."}.to_json)
			end
			
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter." }.to_json)
		end
	end


	def info
		if params[:brand_id].present?
			@brand = @current_user.brands.find_by(:id => params[:brand_id].to_i)
			if !@brand.present?
				render_json({:stat => "fail" ,:code => 400  , :msg => "Brand is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400  , :msg => "Please enter the  brand_id."}.to_json)
		end
	end 

	def get_event_defaults
		if params[:brand_id].present?
			@brand = @current_user.brands.find_by(:id => params[:brand_id].to_i)
			if @brand.present?
				@gallery_layouts = @brand.gallery_layouts
				if !@gallery_layouts.present?
					render_json({:stat => "fail" ,:code => 400 , :msg=>"Event default is not found." }.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg=>"Brand is not found." }.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg=>"Please enter the brand_id"}.to_json)
		end
	end


	def get_event_tree
		if params[:brand_id].present?
			@brand =@current_user.brands.find_by(:id => params[:brand_id].to_i)
			if @brand.present?
				@galleries = @brand.galleries
				if !@galleries.present?
					render_json({:stat => "fail" ,:code => 400 , :msg=>"Event is not found."}.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg=>"Brand is not found."}.to_json)
			end	
		else
			render_json({:stat => "fail" ,:code => 400 , :msg=>"Please enter the brand_id"}.to_json)
		end
	end 

end 