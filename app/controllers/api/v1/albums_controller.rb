class Api::V1::AlbumsController < Api::V1::BaseController 
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token 
	#respond_to :json

	def get_list
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				if !@gallery.present?
		        	render_json({:stat => "fail" ,:code => 400 , :msg => "Event is not found."}.to_json)
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end


	def create
		if params.present?
			if params[:event_id].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)		
				if params[:album_name].present?
					is_parent = false
					level = 0
					if params[:parent_id].present?
						@parent_album = @gallery.albums.find_by(:id => params[:parent_id].to_i) 
						is_parent =true
					else
						@parent_album = 0
					end
					if !@parent_album.present? && is_parent.present?
						render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parent id."}.to_json)
					elsif is_parent.present?
						level = @parent_album.level + 1 
						@parent_album= @parent_album.id
					end 
					# @parent_albums
					if level < 4 
						@album = @gallery.albums.build(:title => params[:album_name] , :password => params[:password] , :parent => @parent_album,:level => level)
						if !@album.save
				 			render_json({:stat => "fail" ,:code => 400 , :msg => "Event is not found."}.to_json)	
						end
					else
						render_json({:stat => "fail" ,:code => 400 , :msg => "Sorry,Can't create further level of sub-album."}.to_json)	
					end
	    		else
					render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the album name."}.to_json)	
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id."}.to_json)	
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid parameter."}.to_json)	
		end
	end 


	def delete
		if params.present?
			if params[:album_id].present?
				@album = Album.find_by(:id => params[:album_id].to_i)
				if @album.present?
					is_empty = true
					if params[:only_empty].to_i == 1
						if  @album.children_album.present? || @album.photos.present
							is_empty = false
						end 
					end 
					if is_empty.present?
						if @album.destroy
							render_json({:stat => "sucess"}.to_json)	
						else
							render_json({:result => {:messages => @album.errors.full_messages ,:rstatus => 0 , :errorcode => 403}}.to_json)			
						end
					else
			  		 	render_json({:stat => "fail" ,:code => 400 , :msg =>"Sorry albums is not empty" }.to_json)	
	       			end
				else
				 	render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found."}.to_json)	
	       		end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id."}.to_json)	
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid parameter."}.to_json)			
		end
	end 

	def move
		if params.present?
			if params[:album_id].present?
				@album = Album.find_by(:id => params[:album_id].to_i)
				if @album.present?
					if params[:parent_id].present? 
						@parent_album = Album.find_by(:id => params[:parent_id].to_i)
						if @parent_album.present?
							level_array = @album.count_sub_album_level([])
							
							puts "-----#{level_array}"

							total_level = @parent_album.level + ((level_array.max - (level_array.min == 0 ? 1 : level_array.min)) + 1) 
							puts "total level of album is #{total_level}-----------"
							if total_level < 4  
								puts "hi test Insite"
								@album.change_sub_level_album(@parent_album.level)
								if @parent_album.photos.count != 0 
									@album.assign_photo_parent_album_to_sub_album(@parent_album)
									@album.update_attributes(:parent => @parent_album.id , :level => @parent_album.level + 1 )
								else
									@album.update_attributes(:parent => @parent_album.id , :level => @parent_album.level + 1 )
								end
							else
								puts "hi test out site"
							 	render_json({:stat => "fail" ,:code => 400 , :msg =>"Sorry,Can't move further level of sub album."}.to_json)	
	    					end
						else
						 	render_json({:stat => "fail" ,:code => 400 , :msg =>"Sorry, Parent Album is not found."}.to_json)	
	    				end					
					else
					 	@album.update_attributes(:parent => 0  , :level => 0)
 	       			end
				else
				 	render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found."}.to_json)	
	       		end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event_id."}.to_json)	
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid parameter."}.to_json)			
		end
	end 

	def rename
		if params.present?
			if params[:album_id].present?
				@gallery = @current_user.galleries.joins(:albums).where("albums.id = ? " , params[:album_id].to_i)
				@album = Album.find_by(:id => params[:album_id].to_i)
				if @album.present?
					if !@album.update_attributes(:title => params[:album_name])
						render_json({:stat => "fail" ,:code => 400 , :msg => @album.errors.full_messages }.to_json)				
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found." }.to_json)	
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the event_id." }.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid parameter."}.to_json)
		end
	end 

	def get_photos
		if params.present?
			if params[:album_id].present?
				@gallery = @current_user.galleries.joins(:albums).where("albums.id = ? " , params[:album_id].to_i)
				@album = Album.find_by(:id => params[:album_id].to_i)
				if @album.present?
					if params[:page].present?
						@photos = @album.photos.page(params[:page]).per(2)
					else
						@photos = @album.photos.page(1).per(2)
					end
					
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found." }.to_json)	
				end
	        else
	        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the event_id." }.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the valid parameter."}.to_json)
		end
	end

end 

