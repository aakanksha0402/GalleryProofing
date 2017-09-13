class Api::V1::PhotosController < Api::V1::BaseController
	before_action :doorkeeper_authorize!
	before_action :authenticate_user_with_access_token

	def upload
		if params.present?
			if params[:event_id].present? && params[:photo].present?
				@gallery = @current_user.galleries.find_by(:id => params[:event_id].to_i)
				if @gallery.present?
					if params[:album_id].present?
						@album = @gallery.albums.find_by(:id => params[:album_id].to_i)
						if !@album.present?
							render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found."}.to_json)
						else
							if @album.children_album.present?
								render_json({:stat => "fail" ,:code => 400 , :msg =>"Sorry, Can't upload image in parent album."}.to_json)
							else
								@photo = @album.photos.build(image: params[:photo])
								#@photo.decode_image_to_image_data(params[:photo])
								if !@photo.save
									render_json({:stat => "fail" ,:code => 400 , :msg => @photo.errors.full_messages}.to_json)
								end
							end
						end
					else
						@photo = @gallery.photos.build(image: params[:photo])
						#@photo.decode_image_to_image_data(params[:photo])
						if !@photo.save
							render_json({:stat => "fail" ,:code => 400 , :msg => @photo.errors.full_messages}.to_json)
						end
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Event is not found."}.to_json)
				end
	        else
       			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the event id and photo."}.to_json)
	        end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg => "Please enter the valid parameter."}.to_json)
		end
	end



	def add_to_album
		if params[:album_id].present? && params[:photo_id].present?
			@album = Album.find_by(:id => params[:album_id].to_i)
			if @album.present?
				if !@album.children_album.present?
					@photo = Photo.find_by(:id => params[:photo_id].to_i)
					if @photo.present?
						if @photo.update_attributes(:imageable_id => @album.id , :imageable_type => "Album")
							render_json({:stat => "success"}.to_json)
						else
							render_json({:stat => "fail" ,:code => 400 , :msg => @photo.errors.full_messages}.to_json)
						end
					else
						render_json({:stat => "fail" ,:code => 400 , :msg =>"Photo is not found."}.to_json)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Sorry, Can't add image in parent album."}.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found."}.to_json)
			end
        else
        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the album id and photo id."}.to_json)
        end
	end


	def remove_from_album
		if params[:album_id].present? && params[:photo_id].present?
			@album = Album.find_by(:id => params[:album_id].to_i)
			if @album.present?
				@photo = @album.photos.find_by(:id => params[:photo_id].to_i)
				if @photo.present?
					if @photo.update_attributes(:imageable_id => @album.gallery.id , :imageable_type => "Gallery")
						render_json({:stat => "success"}.to_json)
					else
						render_json({:stat => "fail" ,:code => 400 , :msg => @photo.errors.full_messages}.to_json)
					end
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>"Photo is not found."}.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg =>"Album is not found."}.to_json)
			end
        else
        	render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the album id and photo id."}.to_json)
        end
	end


	def info
		if params[:photo_id].present?
			@photo = Photo.find_by(:id => params[:photo_id].to_i)
			if !@photo.present?
				render_json({:stat => "fail" ,:code => 400 , :msg =>"Photo is not found." }.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the photo id."}.to_json)
        end
	end



	def delete
		if params[:photo_id].present?
			@photo = Photo.find_by(:id => params[:photo_id].to_i)
			if @photo.present?
				if @photo.destroy
					render_json({:stat => "success" , :deleted => true , :photo_id => @photo.id})
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>@photo.errors.full_messages}.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg =>"Photo is not found."}.to_json)
			end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the photo id."}.to_json)
        end
	end


	def update
		if params[:photo_id].present? && params[:photo].present?
			@photo = Photo.find_by(:id => params[:photo_id].to_i)
			if @photo.present?
				#@photo.decode_image_to_image_data(params[:photo])
				if @photo.update_attributes(image: params[:photo])
					render_json({:stat => "success", :photo_id => @photo.id})
				else
					render_json({:stat => "fail" ,:code => 400 , :msg =>@photo.errors.full_messages }.to_json)
				end
			else
				render_json({:stat => "fail" ,:code => 400 , :msg =>"Photo is not found."}.to_json)
    		end
		else
			render_json({:stat => "fail" ,:code => 400 , :msg =>"Please enter the photo id and new photo."}.to_json)
        end
	end

end
