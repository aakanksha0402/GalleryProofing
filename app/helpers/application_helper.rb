module ApplicationHelper

	def bootstrap_class_for flash_type
	 case flash_type
		 when :success
			 "alert-success"
		 when :error
			 "alert-error"
		 when :alert
			 "alert-block"
		 when :notice
			 "alert-info"
		 else
			 flash_type.to_s
	 end

	# {success: 'alert-success',error: "alert-error",alert: "alert-block",notice: "alert-info/"}[flash_type] || flash_type.to_s
 end

end
