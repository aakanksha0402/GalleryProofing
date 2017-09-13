class Api::V1::CategoriesController < Api::V1::BaseController 
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token 
	#respond_to :json

	def get_list
		@brand = @current_user.brands.get_default_brand
		if @brand.present?
			@categories = @brand.categories
			if !@categories.present?
				render_json({:stat => "fail" ,:code => 400 , :msg => "Category is not available."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Brand is not found."}.to_json)
		end
	end

	def create
		@brand = @current_user.brands.get_default_brand
		if @brand.present?
			if params[:name].present?
				@category = @brand.categories.build(:name => params[:name])
				if !@category.save
					render_json({:stat => "fail" ,:code => 400 , :msg =>  @category.errors.full_messages }.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the caterory name."}.to_json)
			end 
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Brand is not found."}.to_json)
		end
	end 



	def rename
		@brand = @current_user.brands.get_default_brand
		if @brand.present?
			@category = @brand.categories.find_by(:id => params[:category_id].to_i)
			if @category.present?
				if params[:name].present?
					if !@category.update_attributes(:name => params[:name])
						render_json({:stat => "fail" ,:code => 400 , :msg => @category.errors.full_messages}.to_json)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the caterory name."}.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg =>"Category is not found."}.to_json)
			end 
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Brand is not found."}.to_json)
		end
	end

	
end 