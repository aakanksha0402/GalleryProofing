class Api::V1::EventsController < Api::V1::BaseController 
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token 
	#respond_to :json

	def get_list
		
		if params[:brand_id].present?
			@brand = @current_user.brands.find_by(:id => params[:brand_id].to_i)		
		else
			@brand = @current_user.brands.find_by(:default => true)
		end 

		if @brand.present?
			@galleries = @brand.galleries
			if !@galleries.present?
				render_json({:stat => "fail" ,:code => 400 , :msg => "Event is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Brand is not found." }.to_json)
		end
	end

	def create
		if params.present?
			if params[:brand_id].present?
				@brand = @current_user.brands.find_by(:id => params[:brand_id].to_i)		
			else
				@brand = @current_user.brands.find_by(:default => true)
			end 
			if params[:brand_event_default_id].present?
				@gallery_layout = @brand.gallery_layouts.find_by(:id => params[:brand_event_default_id])
			else
				@gallery_layout = @brand.gallery_layouts.find_by(:is_default => true)
			end	
			puts "-------#{@gallery_layout.inspect}"

			@gallery = @brand.galleries.build(:name => params[:event_name] , :contact_id => params[:contact_id] ,:gallery_layout_id => @gallery_layout.id , :shoot_date => params[:event_date] ,:user_id => @current_user.id , :status => "Active" )		
			if !@gallery.save	
				render_json({:stat => "fail" ,:code => 400 , :msg => @gallery.errors.full_messages}.to_json)
			else
				@custome_gallery_layout =  @gallery.build_custom_gallery_layout(((@gallery_layout.as_json).except("id","status","name")).deep_merge(gallery_id: @gallery.id,layout_name: @gallery_layout.name))
        		puts "-----#{@custome_gallery_layout.inspect}"
        		@custome_gallery_layout.save
        	end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end 


	def update
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				if @gallery.present?
					if !@gallery.update_attributes(:name => params[:event_name] , :contact_id =>params[:contact_id] , :shoot_date => params[:event_date])	
						render_json({:stat => "fail" ,:code => 400 , :msg =>  @gallery.errors.full_messages}.to_json)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg => "Event is not found."}.to_json)			
				end
	        else
     			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end


	def delete
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				is_empty = true
				if @gallery.present?
					if params[:only_empty].to_i == 1
						if  @gallery.gallery_photos.count + @gallery.albums.includes(:album_photos).count(:album_photos) != 0
							is_empty = false
						end 
					end 	
					if is_empty.present?
						if @gallery.destroy
							render_json({:stat => "sucess" , :event => {:id => @gallery.id}})
						else
							render_json({:stat => "fail" ,:code => 400 , :msg =>  @gallery.errors.full_messages  }.to_json)
						end
					else
						render_json({:stat => "fail" ,:code => 400 , :msg => "Sorry event is not empty."  }.to_json)
  					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg => "Event is not found."  }.to_json)
  				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id." }.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end

	def rename
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				if @gallery.present?
					if !@gallery.update_attributes(:name => params[:event_name] )	
						render_json({:stat => "fail" ,:code => 400 , :msg => @gallery.errors.full_messages}.to_json)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Event is not found."}.to_json)
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the event_id."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end


	def set_access_level
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)			
				if @gallery.present?
					if !@gallery.custom_gallery_layout.update_attributes(:gallery_access_privacy => params[:access_level] ,:password => params[:password] )	
			        	render_json({:stat => "fail" ,:code => 400 , :msg => @gallery.errors.full_messages }.to_json)
					end
				else
		        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Event is not found." }.to_json)
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the event_id."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end

	#check the photo is exist or not 
	# def photo_exists
	# 	if params.present?
	# 		if params[:event_id].present?
	# 			@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)			
	# 			if @gallery.present?
	# 				if params[:photo_id].present? 
	# 				# if !@gallery.custom_gallery_layout.update_attributes(:gallery_access_privacy => params[:access_level] ,:password => params[:password] )	
	# 				# 	render_json({:result => {:messages => @gallery.errors.full_messages ,:rstatus => 0 , :errorcode => 403}}.to_json)
	# 				# end
	# 			else
	# 				render_json({:result => {:messages => "Event is not found." ,:rstatus => 0 , :errorcode => 403}}.to_json)	
	# 			end
	#         else
	#         	render_json({:result => {:messages => "Please enter the event_id." ,:rstatus => 0 , :errorcode => 403}}.to_json)
	#         end
	# 	else
	# 		render_json({:result => {:messages => "Please enter the valid parameter" ,:rstatus => 0 , :errorcode => 403}}.to_json)
	# 	end
	# end 

	def get_photos
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)			
				if @gallery.present?
					@ids = @gallery.albums.pluck(:id)
					@ids << @gallery.id
					@photos = Photo.where(:imageable_id => @ids)
					if params[:page].present?
						@photos = Photo.where(:imageable_id => @ids).page(params[:page]).per(2)
					else
						@photos = Photo.where(:imageable_id => @ids).page(1).per(2)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Event is not found."}.to_json)
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end 


	def set_category
		if params.present?
			if params[:event_id].present? && params[:category_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				if @gallery.present?
					@category = @gallery.brand.categories.find_by(:id => params[:category_id].to_i)
					if @category.present?
						@gallery.custom_gallery_layout.category_id = @category.id
						puts "-------#{@gallery.custom_gallery_layout.inspect}"
						if !@gallery.save
							render_json({:stat => "fail" ,:code => 400 , :msg =>@gallery.errors.full_messages  }.to_json)	
						end
					else
					   	render_json({:stat => "fail" ,:code => 400 , :msg =>"Category is not found." }.to_json)	
					end
				else	
		    	   	render_json({:stat => "fail" ,:code => 400 , :msg =>"Event is not found." }.to_json)
	     		end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid event_id and category_id." }.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end 

	def set_contact
		if params.present?
			if params[:event_id].present? && !params[:contact_id].nil?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				if @gallery.present?
					is_set = true
					if params[:contact_id].present?
						is_set = true
						@contact = @gallery.brand.contacts.find_by(:id => params[:contact_id].to_i)
					else
						is_set = false
						@contact = @gallery.contact
					end	

					if @contact.present?
						@gallery.contact_id = is_set.present? ? @contact.id : nil
						if !@gallery.save
							render_json({:stat => "fail" ,:code => 400 , :msg => @gallery.errors.full_messages }.to_json)
						end
					else
					  	render_json({:stat => "fail" ,:code => 400 , :msg =>"Contact is not found." }.to_json)
					end
				else
				  	render_json({:stat => "fail" ,:code => 400 , :msg =>"Event is not found."}.to_json)
	      		end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid event_id and contact_id."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end 

	# def gallery_visitors
	# 	if params.present?
	# 		if params[:event_id].present?
	# 			@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
	# 			if @gallery.present?
					
	# 			else
	# 				render_json({:result => {:messages => "Event is not found." ,:rstatus => 0 , :errorcode => 403}}.to_json)	
	# 			end
	#         else
	#         	render_json({:result => {:messages => "Please enter the valid event_id and contact_id." ,:rstatus => 0 , :errorcode => 403}}.to_json)
	#         end
	# 	else
	# 		render_json({:result => {:messages => "Please enter the valid parameter" ,:rstatus => 0 , :errorcode => 403}}.to_json)
	# 	end
	# end

end