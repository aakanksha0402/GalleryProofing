class Api::V1::ContactsController < Api::V1::BaseController 
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token 
	#respond_to :json

	def info
		@contacts = Contact.joins(:brand => [:user]).where("users.id = ? " ,@current_user.id)
		if params[:brand_id].present?
			@contacts = @contacts.includes(:brand).where(:brand_id => params[:brand_id].to_i)
		end

		if params[:contact_id].present?
			@contacts = @contacts.where(:id => params[:contact_id])
		end

		if params[:contact_email].present?
			@contacts = @contacts.where(:email => params[:contact_email])	
		end 	
	end


	def create
		if params[:brand_id].present?
			@brand = @current_user.brands.find_by(:id => params[:brand_id].to_i)
			if @brand.present?
				if !params["tags"].present?
					params["tags"] = ""
				end 
				@contact = @brand.contacts.build(:firstname => params[:first_name] , :lastname => params[:last_name] , :email => params[:email] , :phone_number => params[:phone] , :buisinessname => params[:business_name] , :notes => params[:notes], :address1 => params[:address][:address1] , :address2 => params[:address][:address2]  , :city => params[:address][:city] , :country => params[:address][:country] , :pincode => params[:address][:zip_postal] , :tag_list => params[:tags].split(","))    
				if !@contact.save
					render_json({:stat => "fail" ,:code => 400 , :msg =>@contact.errors.full_messages}.to_json)
				end 
			else
				render_json({:stat => "fail" ,:code => 400 , :msg => "Brand is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the brand_id"}.to_json)
		end
	end 


	def update
		if params[:brand_id].present? && params[:contact_id].present?
			@brand = @current_user.brands.find_by(:id => params[:brand_id].to_i)
			if @brand.present?
				@contact = @brand.contacts.find_by(:id => params[:contact_id].to_i)

				if @contact.present?
				 	if !params["tags"].present?
						params["tags"] = ""
					end 
					if !@contact.update_attributes(:firstname => params[:first_name] , :lastname => params[:last_name] , :email => params[:email] , :phone_number => params[:phone] , :buisinessname => params[:business_name] , :notes => params[:notes], :address1 => params[:address][:address1] , :address2 => params[:address][:address2]  , :city => params[:address][:city] , :country => params[:address][:country] , :pincode => params[:address][:zip_postal]	, :tag_list => params[:tags].split(","))    
						render_json({:stat => "fail" ,:code => 400 , :msg =>@contact.errors.full_messages}.to_json)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Contact is not found."}.to_json)
				end  
			else
				render_json({:stat => "fail" ,:code => 400 , :msg => "Brand is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the brand id and contact id " }.to_json)
		end
	end


	def delete
		if params[:contact_id].present?
			@contact = Contact.find_by(:id => params[:contact_id].to_i)
			if @contact.present?
				if @contact.destroy
					render_json({:stat => "success" , :msg => "Ok" , :contact_id => @contact.id})
				else		
					render_json({:stat => "fail" ,:code => 400 , :msg => @contact.errors.full_messages }.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg => "Contact is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the contact id "  }.to_json)
		end
	end 


	def bulk_create
		if params[:contacts].present?
			@num_of_contact_submitted = params[:contacts].count
			@num_of_valid_contact = 0 
			@num_errors = 0
			@contacts = []
			params[:contacts].each_with_index do |contact,index|
		   	 	@brand = @current_user.brands.find_by(:id => params[:contacts][index.to_s]["brand_id"].to_i)
				if @brand.present?
					@contact = @brand.contacts.build(:firstname => params[:contacts][index.to_s]["first_name"] , :lastname => params[:contacts][index.to_s]["last_name"] , :email => params[:contacts][index.to_s]["email"] , :phone_number => params[:contacts][index.to_s]["phone"] , :buisinessname => params[:contacts][index.to_s]["business_name"] , :notes => params[:contacts][index.to_s]["notes"], :address1 => params[:contacts][index.to_s]["address"]["address1"] , :address2 => params[:contacts][index.to_s]["address"]["address2"]  , :city => params[:contacts][index.to_s]["address"]["city"] , :country => params[:contacts][index.to_s]["address"]["country"] , :pincode => params[:contacts][index.to_s]["address"]["zip_postal"],:tag_list => params[:contacts][index.to_s]["tags"])    
					if @contact.save 
						@num_of_valid_contact += 1
						@contacts << {:is_error => false , :contact_index => index.to_s, :contact =>  @contact }
					else
						@num_errors += 1
						@contacts << { :is_error => true, :contact_index => index.to_s, :messages => @contact.errors.full_messages }
					end 
				else
					@num_errors += 1
					@contacts << { :is_error => true, :contact_index => index.to_s, :messages => ["Brand is not found"]}
				end 
			end 
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the contacts values" }.to_json)
		end
	end 


	def get_event_list
		if params[:contact_id].present?
			@contact = Contact.find_by(:id => params[:contact_id].to_i)
			if @contact.present?
				@galleries = @contact.galleries
			else
				render_json({:stat => "fail" ,:code => 400 , :msg => "Contact is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the contact id "}.to_json)
		end
	end 

end 