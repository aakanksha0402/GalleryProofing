module WatermarkImage
	def create_image_watermark(img_url,font_set,color,text_name,text_opacity_value)
		img = Magick::Image.read(img_url).first
		img = img.change_geometry!('600x400') { |cols, rows, img2|
		 img2.resize!(cols, rows)
		}
		mark = Magick::Image.new(img.rows, img.columns) {self.background_color = "none"}
		draw = Magick::Draw.new
		draw.font = "#{Rails.root}/lib/fonts/#{font_set}.ttf"
		draw.font_family = font_set # set font
		draw.fill = color == "true" ? "white" : "black" # set text color # set text color
		draw.annotate(mark, 0, 0, 0, 0, text_name) do
		  # place the text in the centre of the canvas
		  draw.gravity = Magick::CenterGravity
		  # set text height in points where 1 point is 1/72 inches
		  draw.pointsize = 60
		  draw.stroke = "none" # remove stroke
		end
		mark = mark.rotate(45)
		opacity = text_opacity_value.to_i / 100.00
		img2 = img.dissolve(mark, opacity, 0.5, Magick::CenterGravity)
		trimmed_img = img2.trim
        temp_file = Tempfile.new(["trimmed_image",".png"])
        trimmed_img.write("png:" + temp_file.path)
        return temp_file
	end
	def create_watermark_image(img_url_src,img_url_des,size,gravitytype)
		dst = Magick::Image.read(img_url_des).first
		# dst = dst.resize_to_fill(600,400)
		dst = dst.change_geometry!('600x400') { |cols, rows, img|
		 img.resize!(cols, rows)
		}
		size_change = size.to_i / 100.00
		puts gravitytype.gsub('"', '')
		src = Magick::Image.read(img_url_src).first
		src.resize!(size_change)
		result = dst.composite(src,gravitytype.constantize, Magick::OverCompositeOp)
		trimmed_img = result.trim
        temp_file = Tempfile.new(["trimmed_image",".png"])
        trimmed_img.write("png:" + temp_file.path)
		return temp_file
	end
end
