json.stat "success"
json.num_contacts_submitted @num_of_contact_submitted
json.num_valid_contacts @num_of_valid_contact
json.num_invalid_contacts @num_of_contact_submitted - @num_of_valid_contact
json.num_contacts_created @num_of_valid_contact
json.num_errors @num_errors
json.contacts do
	json.array! @contacts.each_with_index do |contact,index|
		if contact[:is_error].present?
			json.contact_index contact[:contact_index]
			json.error contact[:messages]
		else
			@contact = contact[:contact]
			json.id @contact.id
			json.first_name @contact.firstname
			json.last_name @contact.lastname
			json.email @contact.email
			json.phone @contact.phone_number
			json.bussiness_name @contact.buisinessname
			json.notes @contact.notes
			json.third_party_id ""
			json.brand_id @contact.try(:brand).try(:id)
			json.brand_name @contact.try(:brand).try(:brand_name)
			json.address do 
				json.street_line_1 @contact.address1
				json.street_line_2 @contact.address2
				json.city @contact.city
				json.state_province ""
				json.postal_code @contact.pincode
				json.country @contact.country
			end 
			json.tags @contact.tags.pluck(:name)
		end	
	end 
end
