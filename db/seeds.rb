# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Rake::Task["new_seed:insert_in_default_email_template_type"].execute
Rake::Task["new_seed:insert_in_checkout_status"].execute


default_receipient_atrributes = [
  {name: "All Visitors to this gallery", active: true},
  {name: "Visitors with Favorites", active: true},
  {name: "Visitors with items in their country_lab_attributes", active: true},
  {name: "Visitors who HAVE placed an order", active: true},
  {name: "Visitors who HAVE NOT placed an order", active: true}
]

default_receipient_atrributes.each do |attributes|
  DefaultReceipientType.where(attributes).first_or_create
end

default_trigger_type_atrributes = [
  {name: "X days after gallery expiration date", active: true},
  {name: "X days after gallery release date", active: true},
  {name: "X days after gallery shoot date", active: true},
  {name: "X days before galelry expiration date", active: true}
]

default_trigger_type_atrributes.each do |attributes|
  DefaultTriggerType.where(attributes).first_or_create
end


default_email_template_atrributes = [
  {email_type: "Email Gallery Link", email_subject: "Your Gallery is Ready!",headline: "((gallery.name))",button_text: "VIEW GALLERY", email_body: "<p>Hi!</p><p>Your gallery is ready to be viewed.</p><p>Use the following password to access your photos: ((gallery.password))</p><p>This gallery will expire on ((gallery.expiration_date)).</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use the Gallery Link template to share a gallery with your clients (i.e. - your gallery is ready!)", text_for_button: "Clicking button will open Gallery", default_email_template_type_id: 1},
  {email_type: "Email Mobile App Link", email_subject: "Download Your Mobile App! ((mobile_app.name))",headline: "Your Mobile App is ready!",button_text: "INSTALL APP", email_body: "<p>Hi!</p><p>To download your ((mobile_app.name)) Mobile App, open this email on your phone or tablet and click the button above.</p><p>Enjoy your photos!</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use this template to send a Mobile App link to your client. Learn more about Mobile Apps.", text_for_button: "Clicking button will download app", default_email_template_type_id: 1},
  {email_type: "Gallery Expiring Notice", email_subject: "The ((gallery.name)) Gallery is Expiring!",headline: "Your gallery is expiring!",button_text: "VIEW GALLERY", email_body: "<p>Hi!</p><p>This is a reminder that the ((gallery.name)) gallery will expire on ((gallery.expiration_date)).</p><p>Once it expires, this gallery will no longer be accessible for viewing.</p><p>Use the following password to access your photos:  ((gallery.password))</p><p>Thanks,<br>((brand.name))</p>", text_for_button: "Clicking button will open gallery", text_after_select: "Use this template to email your customers or Gallery Visitors about an upcoming expiration date to encourage print and product purchases!", default_email_template_type_id: 1},
  {email_type: "Gallery Released to Visitors", email_subject: "The ((gallery.name)) Gallery is Live!",headline: "((gallery.name))",button_text: "VIEW GALLERY", email_body: "<p>Hi!</p><p>The photos from the ((gallery.name)) gallery are now available for viewing!</p><p>Please use the following password to access the photos: ((gallery.password))</p><p>This gallery will expire on ((gallery.expiration_date)).</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use this template to let registrants know that a gallery has been released from Pre-Registration mode. Learn more about pre-registration.", text_for_button: "Clicking button will open gallery", default_email_template_type_id: 1},
  {email_type: "Gallery Visitor Message", email_subject: "Message for Visitors.", email_body: "A Message from the Photographer", default_email_template_type_id: 1},
  {email_type: "Invoice Final Payment Due Reminder", email_subject: "Your Final Payment is Due Soon",headline: "Your invoice payment is due soon.",button_text: "VIEW INVOICE", email_body: "<p>Hi!</p><p>The final payment for your invoice from ((brand.name)) is due on ((invoice.final_payment_due)).</p><p>Simply click the button above for details and payment options!</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use this template to notify a client that their final payment will be due soon.", default_email_template_type_id: 2},
  {email_type: "Invoice Past due Notice", email_subject: "Your Invoice is Past Due",headline: "Your invoice payment is past due!",button_text: "VIEW INVOICE", email_body: "<p>Hi!</p><p>The final payment for your invoice from ((brand.name)) was due on ((invoice.final_payment_due)).</p><p>Please click the button above for details and payment options.</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use this template to notify a client that their invoice is past due.", default_email_template_type_id: 2},
  {email_type: "Invoice Ready", email_subject: "An Invoice from ((brand.name))",headline: "Your invoice is ready.",button_text: "VIEW Invoice", email_body: "<p>Hi!</p><p>((invoice.payment_summary_text))</p><p>Click the button above for details and payment options.</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use this template to notify a client that their invoice is ready.", default_email_template_type_id: 2},
  {email_type: "Gallery Upload Finished", email_subject: "Upload is Complete for the ((gallery.name)) Gallery",headline: "",button_text: "", email_body: "<p>Congrats!</p><p>Your photos have been uploaded to the ((gallery.name)) gallery.</p><p>Thanks,<br>The GalleryProof Team </p>", text_after_select: "Use the Gallery Upload Complete template for internal notification emails when an upload is complete in your ShootProof account.", default_email_template_type_id: 3},
  {email_type: "Email Gallery Album Link", email_subject: "Your Album is Ready!",headline: "((album.name))",button_text: "VIEW ALBUM", email_body: "<p>Hi!</p><p>Your album is ready to be viewed.</p><p>Use the following password to access your photos: ((album.password))</p><p>This gallery will expire on ((gallery.expiration_date)).</p><p>Thanks,<br>((brand.name))</p>", text_after_select: "Use this template to share a only a specific album within a gallery.", text_for_button: "Clicking button will open album", default_email_template_type_id: 3},
  {email_type: "Order Status Notice", email_subject: "An Update for Order #((order.number))",headline: "Your order's status has changed!",button_text: "VIEW GALLERY", email_body: "<p>Thanks,<br>((brand.name))</p>", text_after_select: "Use the Order Status Notice template to create your own pre-defined order status messages that you may choose from when changing the status of an order. Create a new template for each order status, as you see fit, or create one to use as a general message template for all order status changes.", default_email_template_type_id: 4}
]

default_email_template_atrributes.each do |attributes|
  DefaultEmailTemplate.where(attributes).first_or_create
end

# pricing data
pricing_atrributes = [
  { name: 'Self-Fulfilled-CommonItems', is_deleted: false},
  {name: 'Self-Fulfilled-Empty', is_deleted: false },
  {name: 'Lab-Fame',is_deleted: false,lab_id: 1},
  {name: 'Lab-John',is_deleted: false,lab_id: 2},
  {name: 'Lab-Senorita',is_deleted: false,lab_id: 3},
  {name: 'Lab-Soham',is_deleted: false,lab_id: 4},
  {name: 'Lab-Diamonds',is_deleted: false,lab_id: 5}
]

pricing_atrributes.each do |attributes|
  PricingStyle.where(attributes).first_or_create
end

# Fix_group default data
fix_group_atrributes = [
  { name: 'Prints', is_deleted: false},
  { name: 'Digital Media', is_deleted: false},
  { name: 'Canvases', is_deleted: false},
  { name: 'Metals', is_deleted: false},
  { name: 'Products', is_deleted: false},
  { name: 'Satin', is_deleted: false},
]

fix_group_atrributes.each do |attributes|
  FixGroup.where(attributes).first_or_create
end

# fixture data for pricing items
sub_item_atrributes = [
  { name: 'Lustre - square corners' },
  { name: 'Lustre - rounded corners' },
  { name: 'Glossy - square corners' },
  { name: 'Glossy - rounded corners' },
  { name: 'Metallic - square corners' },
  { name: 'Metallic - rounded corners' },
  { name: 'Lustre' },
  { name: 'Glossy' },
  { name: 'Metallic' },
  { name: 'Matte' },
  { name: 'Satin' }
]

sub_item_atrributes.each do |attributes|
  SubItem.where(attributes).first_or_create
end

item_list_atrributes = [
  { size_one: 2.5,size_two: 3.5,depth: 8, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 3,size_two: 3, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 3,size_two: 4, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 4,size_two: 4, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 3.5,size_two: 5, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 3,size_two: 6, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 4,size_two: 5, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 4,size_two: 6, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 5,size_two: 5, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 4,size_two: 8, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 5,size_two: 7, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 6,size_two: 6, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 5.5,size_two: 8.5, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 4,size_two: 12, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 6,size_two: 8, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 7,size_two: 7, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 5,size_two: 10, group_name: 'Prints' ,fix_group_id: 1 },
  { size_one: 5,size_two: 5, group_name: 'Prints' ,fix_group_id: 3 },

]

item_list_atrributes.each do |attributes|
  ItemList.where(attributes).first_or_create
end

item_list_sub_item_atrributes = [
  { item_list_id: 1,sub_item_id: 1 },
  { item_list_id: 1,sub_item_id: 2 },
  { item_list_id: 1,sub_item_id: 3 },
  { item_list_id: 1,sub_item_id: 4 },
  { item_list_id: 1,sub_item_id: 5 },
  { item_list_id: 1,sub_item_id: 6 },
  { item_list_id: 2,sub_item_id: 7 },
  { item_list_id: 2,sub_item_id: 8 },
  { item_list_id: 2,sub_item_id: 9 },
  { item_list_id: 2,sub_item_id: 10 },
  { item_list_id: 3,sub_item_id: 7 },
  { item_list_id: 3,sub_item_id: 8 },
  { item_list_id: 3,sub_item_id: 9 },
  { item_list_id: 3,sub_item_id: 10 },
  { item_list_id: 4,sub_item_id: 7 },
  { item_list_id: 4,sub_item_id: 8 },
  { item_list_id: 4,sub_item_id: 9 },
  { item_list_id: 4,sub_item_id: 10 },
  { item_list_id: 5,sub_item_id: 7 },
  { item_list_id: 5,sub_item_id: 8 },
  { item_list_id: 5,sub_item_id: 9 },
  { item_list_id: 5,sub_item_id: 10 },
  { item_list_id: 6,sub_item_id: 7 },
  { item_list_id: 6,sub_item_id: 8 },
  { item_list_id: 6,sub_item_id: 9 },
  { item_list_id: 6,sub_item_id: 10 },
  { item_list_id: 7,sub_item_id: 7 },
  { item_list_id: 7,sub_item_id: 8 },
  { item_list_id: 7,sub_item_id: 9 },
  { item_list_id: 7,sub_item_id: 10 },
  { item_list_id: 8,sub_item_id: 7 },
  { item_list_id: 8,sub_item_id: 8 },
  { item_list_id: 8,sub_item_id: 9 },
  { item_list_id: 8,sub_item_id: 10 },
  { item_list_id: 9,sub_item_id: 7 },
  { item_list_id: 9,sub_item_id: 8 },
  { item_list_id: 9,sub_item_id: 9 },
  { item_list_id: 9,sub_item_id: 10 },
  { item_list_id: 10,sub_item_id: 7 },
  { item_list_id: 10,sub_item_id: 8 },
  { item_list_id: 10,sub_item_id: 9 },
  { item_list_id: 10,sub_item_id: 10 },
  { item_list_id: 11,sub_item_id: 7 },
  { item_list_id: 11,sub_item_id: 8 },
  { item_list_id: 11,sub_item_id: 9 },
  { item_list_id: 11,sub_item_id: 10 },
  { item_list_id: 12,sub_item_id: 7 },
  { item_list_id: 12,sub_item_id: 8 },
  { item_list_id: 12,sub_item_id: 9 },
  { item_list_id: 12,sub_item_id: 10 },
  { item_list_id: 13,sub_item_id: 7 },
  { item_list_id: 13,sub_item_id: 8 },
  { item_list_id: 13,sub_item_id: 9 },
  { item_list_id: 13,sub_item_id: 10 },
  { item_list_id: 14,sub_item_id: 7 },
  { item_list_id: 14,sub_item_id: 8 },
  { item_list_id: 14,sub_item_id: 9 },
  { item_list_id: 14,sub_item_id: 10 },
  { item_list_id: 15,sub_item_id: 7 },
  { item_list_id: 15,sub_item_id: 8 },
  { item_list_id: 15,sub_item_id: 9 },
  { item_list_id: 15,sub_item_id: 10 },
  { item_list_id: 16,sub_item_id: 7 },
  { item_list_id: 16,sub_item_id: 8 },
  { item_list_id: 16,sub_item_id: 9 },
  { item_list_id: 16,sub_item_id: 10 },
  { item_list_id: 17,sub_item_id: 7 },
  { item_list_id: 17,sub_item_id: 8 },
  { item_list_id: 17,sub_item_id: 9 },
  { item_list_id: 17,sub_item_id: 10 },
  { item_list_id: 18,sub_item_id: 7  },
  { item_list_id: 18,sub_item_id: 8 },
  { item_list_id: 18,sub_item_id: 11 }
]

item_list_sub_item_atrributes.each do |attributes|
  ItemListSubItem.where(attributes).first_or_create
end

country_attributes=[
  {name: "Argentina"},
  {name: "Australia"},
  {name: "Austria"},
  {name: "Belgium"},
  {name: "Brazil"},
  {name: "Canada"},
  {name: "Chile"},
  {name: "Colombia"},
  {name: "Denmark"},
  {name: "Ecuador"},
  {name: "Finland"},
  {name: "France"},
  {name: "Germany"},
  {name: "Greece"},
  {name: "India"},
  {name: "Ireland"},
  {name: "Israel"},
  {name: "Italy"},
  {name: "Mexico"},
  {name: "Netherlands"},
  {name: "New Zealand"},
  {name: "Norway"},
  {name: "Philippines"},
  {name: "Poland"},
  {name: "Singapore"},
  {name: "Slovenia"},
  {name: "South Africa"},
  {name: "Spain"},
  {name: "Sweden"},
  {name: "Switzerland"},
  {name: "United Arab Emirates"},
  {name: "United Kingdom"},
  {name: "United States"}
]

country_attributes.each do |attributes|
  Country.where(attributes).first_or_create
end

state_provinces_attributes=[
  {country_id:2,name: "Australian Capital Territory",abbrevation: "AU_ACT"},
  {country_id:2,name: "New South Wales",abbrevation: "AU_NSW"},
  {country_id:2,name: "Northern Territory",abbrevation: "AU_NT"},
  {country_id:2,name: "Queensland",abbrevation: "AU_QLD"},
  {country_id:2,name: "South Australia",abbrevation: "AU_SA"},
  {country_id:2,name: "Tasmania",abbrevation: "AU_TAS"},
  {country_id:2,name: "Victoria",abbrevation: "AU_VIC"},
  {country_id:2,name: "Western Australia",abbrevation: "AU_WA"},
  {country_id:6,name: "Alberta",abbrevation: "CA_AB"},
  {country_id:6,name: "British Columbia",abbrevation: "CA_BC"},
  {country_id:6,name: "Manitoba",abbrevation: "CA_MB"},
  {country_id:6,name: "New Brunswick",abbrevation: "CA_NB"},
  {country_id:6,name: "Newfoundland and Labrador",abbrevation: "CA_NL"},
  {country_id:6,name: "Northwest Territories",abbrevation: "CA_NT"},
  {country_id:6,name: "Nova Scotia",abbrevation: "CA_NS"},
  {country_id:6,name: "Nunavut",abbrevation: "CA_NU"},
  {country_id:6,name: "Ontario",abbrevation: "CA_ON"},
  {country_id:6,name: "Prince Edward Island",abbrevation: "CA_PE"},
  {country_id:6,name: "Quebec",abbrevation: "CA_QC"},
  {country_id:6,name: "Saskatchewan",abbrevation: "CA_SK"},
  {country_id:6,name: "Yukon",abbrevation: "CA_YU"},
]

state_provinces_attributes.each do |attributes|
  StateProvince.where(attributes).first_or_create
end


lab_attributes=[
  {name: "Lab-Fame",email_id: "fame@gmail.com",address1: "City Garden Road",city: "New York",country: "USA",pincode: "10001",phone_number: "415-701-2311"},
  {name: "Lab-John",email_id: "john@gmail.com",address1: "123 High Street",city: "London",country: "UK",pincode: "358741",phone_number: "44 20 7123 4567"},
  {name: "Lab-Senorita",email_id: "senorita@gmail.com",address1: "New Orchards",city: "Seville",country: "Spain",pincode: "03000",phone_number: "34 85 4785 2541"},
  {name: "Lab-Soham",email_id: "soham@gmail.com",address1: "New Delhi",city: "Delhi",country: "India",pincode: "396015",phone_number: "9998887770"},
  {name: "Lab-Diamonds",email_id: "diamonds@gmail.com",address1: "Charles Street",city: "Sydney",country: "Australia",pincode: "NSW 2000",phone_number: "61 8547 8541"}
]

lab_attributes.each do |attributes|
  Lab.where(attributes).first_or_create
end

country_lab_attributes=[
  {country_id: 6,lab_id: 1},
  {country_id: 6,lab_id: 2},
  {country_id: 6,lab_id: 3},
  {country_id: 2,lab_id: 1},
  {country_id: 2,lab_id: 4}
]

country_lab_attributes.each do |attributes|
  CountryLab.where(attributes).first_or_create
end

data_plan_attributes=[
  {photos_number: "100", mobile_apps_number: "5", invoices_number: "-", data_period: "Monthly", plan_price: "0"},
  {photos_number: "100", mobile_apps_number: "5", invoices_number: "-", data_period: "Yearly", plan_price: ""},
  {photos_number: "1,500", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Monthly", plan_price: "10"},
  {photos_number: "1,500", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Yearly", plan_price: "100"},
  {photos_number: "5,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Monthly", plan_price: "20"},
  {photos_number: "5,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Yearly", plan_price: "200"},
  {photos_number: "25,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Monthly", plan_price: "30"},
  {photos_number: "25,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Yearly", plan_price: "300"},
  {photos_number: "50,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Monthly", plan_price: "40"},
  {photos_number: "50,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Yearly", plan_price: "400"},
  {photos_number: "1,00,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Monthly", plan_price: "50"},
  {photos_number: "1,00,000", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Yearly", plan_price: "500"},
  {photos_number: "Unlimited", mobile_apps_number: "Unlimited", invoices_number: "Yes", data_period: "Monthly", plan_price: "60"}
]

data_plan_attributes.each do |attributes|
  DataPlan.where(attributes).first_or_create
end


music_categories_attributes=[
{id: 1, name: "Unlimited", svg: "<g>
  <path d='M45.6,19.3H14.3l0-3.1c0-1.1,0.9-2,2-2h27.3c1.1,0,2,0.9,2,2V19.3'></path>
  <path d='M40.8,11.9H19.2v-1c0-1.1,0.9-2,2-2h17.5c1.1,0,2,0.9,2,2V11.9'></path>
  <path d='M45.7,22H14.3c-2.2,0-4.1,1.8-4.1,4.1V47c0,2.2,1.8,4.1,4.1,4.1h31.3c2.2,0,4.1-1.8,4.1-4.1V26.1
    C49.7,23.8,47.9,22,45.7,22z M23.1,28.7l15-3.2v4.2v1.2v10.8h0c0,0.1,0,0.1,0,0.2c0,2-1.6,3.5-3.5,3.5c-2,0-3.5-1.6-3.5-3.5
    c0-2,1.6-3.5,3.5-3.5c0.3,0,0.7,0,1,0.1v-7.2l-9.9,2.2v10.6h0c0,0.1,0,0.1,0,0.2c0,1.9-1.6,3.5-3.5,3.5s-3.5-1.6-3.5-3.5
    c0-1.9,1.6-3.5,3.5-3.5c0.3,0,0.6,0,0.9,0.1L23.1,28.7z'></path>
</g>"},
{id: 2, name: "Weddings and Love", svg: "<g>
  <path fill-rule='evenodd' clip-rule='evenodd' d='M38.1,17.4c-3.7,0-7.1,1.2-10,3.2c-1-0.6-2-1.1-3-1.5l4.3-2.8
    c0.8-0.5,1-1.5,0.5-2.2l-1.2-1.8c-0.2-0.3-0.5-0.5-0.9-0.6l-6.6-1.4c-0.4-0.1-0.8,0-1.1,0.2l-1.9,1.2c-0.8,0.5-1,1.5-0.5,2.2
    l2.8,4.3c-0.2,0-0.5,0-0.7,0c-8.7,0-15.7,7.1-15.6,15.8c0.1,8.4,6.9,15.2,15.3,15.4c1.7,0,3.4-0.2,4.9-0.7c-1.5-1.4-2.7-3-3.5-4.9
    c-0.4,0-0.7,0.1-1.1,0.1c-5.6,0-10.1-4.5-10.1-10.1c0-4,2.3-7.4,5.7-9.1c1.3-0.6,2.7-0.9,4.2-0.9c5.6,0,10.1,4.5,10.1,10.1
    c0,1.3-0.4,3.6-1.6,5.4c-0.7-1.4-1-3-1-4.7c0-0.8,0.1-1.5,0.2-2.2c-0.8-2.3-2.4-4.2-4.5-5.3c-1.2,2.4-1.8,5-1.8,7.8
    c0.1,9.4,8,17,17.4,16.9C47.5,51.4,55,44,55.1,34.7C55.3,25.2,47.6,17.4,38.1,17.4z M38,45.5c-2.3,0-4.5-0.7-6.3-1.9
    c2.2-2.7,3.6-6.2,3.6-9.9c0-3.3-1-6.3-2.7-8.8c1.6-0.9,3.5-1.4,5.4-1.4c6.1,0,11.1,5,11.1,11.1C49.1,40.6,44.1,45.5,38,45.5z'></path>
 </g>"},
{id: 3, name: "Babies", svg: "<g>
  <path d='M21.6,9.8c-3.5,0-6.3,3.5-6.3,7.7c0,4.3,2.8,7.7,6.3,7.7s6.3-3.5,6.3-7.7C27.9,13.2,25.1,9.8,21.6,9.8z'></path>
  <path d='M38.6,14.7c-2.8,0-5.1,2.9-5.1,6.4s2.3,6.4,5.1,6.4c2.8,0,5.1-2.9,5.1-6.4S41.4,14.7,38.6,14.7z'></path>
  <path d='M43.9,27.2c-1.4,1.6-3.2,2.6-5.3,2.6c-2.1,0-3.9-1-5.3-2.6c-0.9,0.3-1.7,0.7-2.4,1.3
    c-0.9-1.4-2.3-2.5-3.8-3.1c-1.5,1.4-3.4,2.2-5.4,2.2c-2.1,0-4.1-0.9-5.6-2.3c-3.3,1.1-5.6,4.1-5.6,7.8V45c0,2.8,2.3,5.1,5.1,5.1
    h7.9v-3.9c0-1.5,0.6-2.8,1.6-3.8c1.3,1.6,3.3,2.6,5.6,2.6c2.2,0,4.1-1,5.5-2.5c0.9,0.9,1.5,2.2,1.5,3.6v4.1h8.7
    c1.9,0,3.5-1.6,3.5-3.5V35C49.6,31.4,47.2,28.3,43.9,27.2z M30.4,42.7c-2.9,0-5.2-2.5-5.2-5.7c0-3.1,2.3-5.7,5.2-5.7
    c2.9,0,5.2,2.5,5.2,5.7C35.6,40.2,33.3,42.7,30.4,42.7z'></path>
</g>"},
{id: 4, name: "HighSchool", svg: "
<g>
<path d='M27.5,36.3l-15.3-5.4v8.5h0c0.2,2.6,11.6,8.8,16.8,8.8c5.4,0,16.6-6.3,16.8-8.8h0v-8.3l-15.3,5.3
  C29.6,36.7,28.5,36.7,27.5,36.3z'></path>
<path d='M56.8,22.4l-5.9-1.8l-11.5,4.1c-1.1,0.4-2.2,0.4-3.3,0l-1.2-0.4c-0.6-0.2-0.6-1.1,0-1.3L45.8,19l-15.6-4.7
  c-0.7-0.2-1.5-0.2-2.2,0L1.5,22c-0.6,0.2-0.6,1,0,1.2l26,9.2c1,0.4,2.1,0.4,3.1,0l26.2-9C57.3,23.3,57.3,22.5,56.8,22.4z'></path>
<path d='M53.9,48.6c0-1.2-0.7-2.3-1.7-2.9V27.9c-0.4,0.3-1.4,0.6-2.7,0.6c-0.2,0-0.3,0-0.5,0v17.3
  c-1,0.6-1.7,1.6-1.7,2.9c0,0,0,0,0,0.1h0v5.7h0c0.1,0.7,1.5,1.3,3.2,1.3c1.8,0,3.2-0.6,3.2-1.3h0V48.6L53.9,48.6
  C53.9,48.6,53.9,48.6,53.9,48.6z'></path>
</g>"},
{id: 5, name: "Boudior and Fashion", svg: "<g>
  <path d='M19.7,27c-1.6-0.5-2.8-1.7-3.3-3.3c-0.1-0.2-0.2-0.3-0.4-0.3s-0.4,0.1-0.4,0.3c-0.5,1.6-1.7,2.8-3.3,3.3
    c-0.2,0.1-0.3,0.2-0.3,0.4s0.1,0.4,0.3,0.4c1.6,0.5,2.8,1.7,3.3,3.3c0.1,0.2,0.2,0.3,0.4,0.3s0.4-0.1,0.4-0.3
    c0.5-1.6,1.7-2.8,3.3-3.3c0.2-0.1,0.3-0.2,0.3-0.4S19.9,27.1,19.7,27z'></path>
</g>
<path d='M38.8,35.3c0.1-0.1,0.2-0.2,0.3-0.3c0.3-0.3,0.8-0.8,1.2-1.2c0.3-0.3,0.5-0.4,0.7-0.5
  c0.1,0.2,0.2,0.5,0.2,1.2c0.1,0.8,0,1.6,0,2.3c0,0.2,0,0.4,0,0.6v8.3v1h1h2.8h1v-1v-4.4c0-5.4,0.6-9.5,1.6-11.4
  c1.7-2.6,2.5-5.1,2.5-7.4c0-0.2,0-0.4,0-0.6c-0.2-2-0.8-3.9-1.7-5.2c-0.1-0.1-0.1-0.2-0.2-0.3c-0.5-0.8-1.4-2.2-2.9-2.2h-0.2
  l-0.2,0.1c-0.1,0.1-2.8,1.3-5.5,4c-1.1,1.1-2.1,2.6-2.9,3.8c-0.4,0.6-0.7,1.2-1.1,1.8c-2.3,3.9-5,8.3-10,11.8
  c-1.1,0.7-1.9,0.9-3.3,0.9c-0.7,0-1.5-0.4-2.2-1c-0.5-0.5-1.3-0.8-2-0.8c-0.6,0-1.1,0.2-1.6,0.5l0,0l0,0l-3.7,3L9,41.3
  c-0.8,0.5-1.3,1-1.6,1.6c-0.4,0.6-0.4,1.3-0.2,2c0.4,1.3,1.7,2.1,3.3,2.1c2.6,0,4,0,5.2,0c0.9,0,1.7,0,2.7,0c2.6,0,5-0.4,7.1-1.1
  c1.9-0.6,3.5-1.5,5-2.6L38.8,35.3z'></path>
<g>
  <path d='M32.2,19.4c-2.9-0.8-5.2-3.1-6-6c-0.1-0.3-0.4-0.6-0.8-0.6s-0.7,0.2-0.8,0.6c-0.8,2.9-3.1,5.2-6,6
    c-0.3,0.1-0.6,0.4-0.6,0.8c0,0.4,0.2,0.7,0.6,0.8c2.9,0.8,5.2,3.1,6,6c0.1,0.3,0.4,0.6,0.8,0.6s0.7-0.2,0.8-0.6
    c0.8-2.9,3.1-5.2,6-6c0.3-0.1,0.6-0.4,0.6-0.8C32.7,19.8,32.5,19.5,32.2,19.4z'></path>
</g>
</g>"},
{id: 6, name: "Sports", svg: "<g>
  <path d='M9.9,41c-0.1,1.3,0,2.6,0,3.7c0.1,2,1.8,3.5,3.7,3.6c1,0,2.1,0,3.2,0c0.5,0,0.7-0.6,0.4-1l-6.6-6.6
    C10.3,40.4,9.9,40.6,9.9,41z'></path>
  <path d='M39.3,10.8l6.7,6.7c0.3,0.3,0.8,0.1,0.8-0.3c0.1-1.5,0-2.9-0.1-4.2c-0.1-1.6-1.4-2.9-3-3
    c-1.3-0.1-2.7-0.1-4.1,0C39.2,10,39,10.5,39.3,10.8z'></path>
  <path d='M18.4,19.2c-3.9,3.9-6.2,8.9-7.4,13.9c-0.2,0.8,0.1,1.6,0.6,2.1c2.3,2.3,8.7,8.7,11.1,11.1
    c0.6,0.6,1.4,0.8,2.3,0.6c4.7-1.4,9.5-3.9,13.4-7.8c3.9-3.9,6.2-8.8,7.4-13.8c0.2-0.8-0.1-1.7-0.7-2.3L34,12.1
    c-0.6-0.6-1.5-0.9-2.4-0.6C26.9,12.9,22.2,15.3,18.4,19.2z M35.4,25.4c0.5,0.5,0.5,1.4,0,1.9s-1.4,0.5-1.9,0l-0.7-0.7l-1.3,1.3
    l0.7,0.7c0.5,0.5,0.5,1.4,0,1.9c-0.5,0.5-1.4,0.5-1.9,0l-0.7-0.7l-1.3,1.3l0.7,0.7c0.5,0.5,0.5,1.4,0,1.9s-1.4,0.5-1.9,0l-0.7-0.7
    l-1.3,1.3l0.7,0.7c0.5,0.5,0.5,1.4,0,1.9s-1.4,0.5-1.9,0l-3.7-3.7c-0.5-0.5-0.5-1.4,0-1.9c0.5-0.5,1.4-0.5,1.9,0l1,1l1.3-1.3l-1-1
    c-0.5-0.5-0.5-1.4,0-1.9s1.4-0.5,1.9,0l1,1l1.3-1.3l-1-1c-0.5-0.5-0.5-1.4,0-1.9c0.5-0.5,1.4-0.5,1.9,0l1,1l1.3-1.3l-1-1
    c-0.5-0.5-0.5-1.4,0-1.9s1.4-0.5,1.9,0L35.4,25.4z'></path>
  <path d='M45.2,33.9c-0.5,1.1-1.2,2.2-1.9,3.2c2,2.1,4.3,4,6.8,5.5C50.5,38.9,48.4,35.5,45.2,33.9z'></path>
  <path d='M47.9,44.8c-1.9-1-3.7-2.3-5.3-3.9c-0.4-0.4-0.8-0.8-1.1-1.2c-0.4,0.5-0.8,0.9-1.3,1.4
    c-0.2,0.2-0.5,0.5-0.7,0.7c2.1,1.9,4,4,5.6,6.3c0.4,0.6,1.2,0.7,1.7,0.3c0.6-0.4,1.1-0.9,1.5-1.4C48.8,46.2,48.6,45.2,47.9,44.8z'></path>
  <path d='M37.2,43.6c-1,0.8-2.1,1.5-3.2,2.1c1.3,2.3,3.6,3.9,6.5,4.3c0.8,0.1,1.6,0.1,2.4-0.1
    C41.2,47.6,39.3,45.5,37.2,43.6z'></path>
</g>"}
]

music_categories_attributes.each do |attributes|
  MusicCategory.where(attributes).first_or_create
end

music_plan_attributes=[
  {name: "Unlimited (all songs)", no_of_songs: "14,000", songs_per_playlist: "20", data_period: "Month", price: "$10 per Month",  music_category_id: 1},
  {name: "Unlimited (all songs)", no_of_songs: "14,000", songs_per_playlist: "20", data_period: "Year", price: "$100 per Year",  music_category_id: 1},
  {name: "Weddings and Love", no_of_songs: "100", songs_per_playlist: "3", data_period: "Month", price: "$5 per Month", music_category_id: 2},
  {name: "Weddings and Love", no_of_songs: "100", songs_per_playlist: "3", data_period: "Year", price: "$50 per Year", music_category_id: 2},
  {name: "Babies, Kids & Family", no_of_songs: "100", songs_per_playlist: "3", data_period: "Month", price: "$5 per Month",  music_category_id: 3},
  {name: "Babies, Kids & Family", no_of_songs: "100", songs_per_playlist: "3", data_period: "Year", price: "$50 per Year",  music_category_id: 3},
  {name: "High School Seniors", no_of_songs: "100", songs_per_playlist: "3", data_period: "Month", price: "$5 per Month", music_category_id: 4},
  {name: "High School Seniors", no_of_songs: "100", songs_per_playlist: "3", data_period: "Year", price: "$50 per Year",  music_category_id: 4},
  {name: "Boudoir & Fashion", no_of_songs: "100", songs_per_playlist: "3", data_period: "Month", price: "$5 per Month",  music_category_id: 5},
  {name: "Boudoir & Fashion", no_of_songs: "100", songs_per_playlist: "3", data_period: "Year", price: "$50 per Year",  music_category_id: 5},
  {name: "Sports & Action", no_of_songs: "100", songs_per_playlist: "3", data_period: "Month", price: "$5 per Month", music_category_id: 6},
  {name: "Sports & Action", no_of_songs: "100", songs_per_playlist: "3", data_period: "Year", price: "$50 per Year", music_category_id: 6}
]

music_plan_attributes.each do |attributes|
  MusicPlan.where(attributes).first_or_create
end

section_attributes=[
  {section_name: "Studio"},
  {section_name: "Commerce"},
  {section_name: "Photos"},
  {section_name: "Reports"},
  {section_name: "Administration"}
]

section_attributes.each do |attributes|
  Section.where(attributes).first_or_create
end

permission_action_attributes=[
  {name: "View"},
  {name: "Add"},
  {name: "Edit"}
]

permission_action_attributes.each do |attributes|
  PermissionAction.where(attributes).first_or_create
end

permission_section_attributes=[
  {name: "Contact",section_id: 1},
  {name: "Email Template",section_id: 1},
  {name: "Color and Logos",section_id: 1},
  {name: "HomePage",section_id: 1},
  {name: "Galleries",section_id: 3},
  {name: "Delete Galleries",section_id: 3},
  {name: "Photos within Galleries",section_id: 3},
  {name: "Mobile App",section_id: 3},
  {name: "Default Gallery Settings",section_id: 3},
  {name: "Music",section_id: 3},
  {name: "Watermarks",section_id: 3},
  {name: "Tools",section_id: 3},
  {name: "Orders",section_id: 2},
  {name: "Payments",section_id: 2},
  {name: "Request Withdrawals",section_id: 2},
  {name: "Pricing",section_id: 2},
  {name: "Invoices",section_id: 2},
  {name: "Gallery Visitors",section_id: 4},
  {name: "Sales",section_id: 4},
  {name: "Order and Order Files",section_id: 4},
  {name: "Invoices",section_id: 4},
  {name: "Items",section_id: 4},
  {name: "Administration",section_id: 5}
]

permission_section_attributes.each do |attributes|
  PermissionSection.where(attributes).first_or_create
end

permission_action_permission_section_attributes=[
  {permission_action_id: 1, permission_section_id: 1, value: false, name: "View Contact",section_id: 1},
  {permission_action_id: 2, permission_section_id: 1, value: false, name: "Add Contact",section_id: 1},
  {permission_action_id: 3, permission_section_id: 1, value: false, name: "Edit Contact",section_id: 1},

  {permission_action_id: 1, permission_section_id: 2, value: false, name: "View Email Template",section_id: 1},
  {permission_action_id: 2, permission_section_id: 2, value: false, name: "Add Email Template",section_id: 1},
  {permission_action_id: 3, permission_section_id: 2, value: false, name: "Edit Email Template",section_id: 1},

  {permission_action_id: 1, permission_section_id: 3, value: false, name: "View Color and Logos",section_id: 1},
  {permission_action_id: 2, permission_section_id: 3, value: false, name: "Add Color and Logos",section_id: 1},
  {permission_action_id: 3, permission_section_id: 3, value: false, name: "Edit Color and Logos",section_id: 1},

  {permission_action_id: 3, permission_section_id: 4, value: false, name: "Edit HomePage",section_id: 1},

  {permission_action_id: 1, permission_section_id: 13, value: false, name: "View Orders", section_id: 2},
  {permission_action_id: 3, permission_section_id: 13, value: false, name: "Edit Orders", section_id: 2},

  {permission_action_id: 1, permission_section_id: 14, value: false, name: "View Payments", section_id: 2},

  {permission_action_id: 3, permission_section_id: 15, value: false, name: "Edit Request Withdrawal", section_id: 2},

  {permission_action_id: 1, permission_section_id: 16, value: false, name: "View Pricing", section_id: 2},
  {permission_action_id: 2, permission_section_id: 16, value: false, name: "Add Pricing", section_id: 2},
  {permission_action_id: 3, permission_section_id: 16, value: false, name: "Edit Pricing", section_id: 2},

  {permission_action_id: 1, permission_section_id: 17, value: false, name: "View Invoices", section_id: 2},
  {permission_action_id: 2, permission_section_id: 17, value: false, name: "Add Invoices", section_id: 2},
  {permission_action_id: 3, permission_section_id: 17, value: false, name: "Edit Invoices", section_id: 2},

  {permission_action_id: 1, permission_section_id: 5, value: false, name: "View Galleries", section_id: 3},
  {permission_action_id: 2, permission_section_id: 5, value: false, name: "Add Galleries", section_id: 3},
  {permission_action_id: 3, permission_section_id: 5, value: false, name: "Edit Galleries", section_id: 3},

  {permission_action_id: 3, permission_section_id: 6, value: false, name: "Delete Edit Galleries", section_id: 3},

  {permission_action_id: 2, permission_section_id: 7, value: false, name: "Add Photos within Galleries", section_id: 3},
  {permission_action_id: 3, permission_section_id: 7, value: false, name: "Edit Photos within Galleries", section_id: 3},

  {permission_action_id: 1, permission_section_id: 8, value: false, name: "View Mobile Apps", section_id: 3},
  {permission_action_id: 2, permission_section_id: 8, value: false, name: "Add Mobile Apps", section_id: 3},
  {permission_action_id: 3, permission_section_id: 8, value: false, name: "Edit Mobile Apps", section_id: 3},

  {permission_action_id: 1, permission_section_id: 9, value: false, name: "View Default Gallery Settings", section_id: 3},
  {permission_action_id: 2, permission_section_id: 9, value: false, name: "Add Default Gallery Settings", section_id: 3},
  {permission_action_id: 3, permission_section_id: 9, value: false, name: "Edit Default Gallery Settings", section_id: 3},

  {permission_action_id: 1, permission_section_id: 10, value: false, name: "View Music", section_id: 3},
  {permission_action_id: 3, permission_section_id: 10, value: false, name: "Edit Music", section_id: 3},

  {permission_action_id: 1, permission_section_id: 11, value: false, name: "View Watermarks", section_id: 3},
  {permission_action_id: 2, permission_section_id: 11, value: false, name: "Add Watermarks", section_id: 3},
  {permission_action_id: 3, permission_section_id: 11, value: false, name: "Edit Watermarks", section_id: 3},

  {permission_action_id: 1, permission_section_id: 12, value: false, name: "View Tools", section_id: 3},
  {permission_action_id: 2, permission_section_id: 12, value: false, name: "Add Tools", section_id: 3},
  {permission_action_id: 3, permission_section_id: 12, value: false, name: "Edit Tools", section_id: 3},

  {permission_action_id: 1, permission_section_id: 18, value: false, name: "View Gallery Visitors", section_id: 4},

  {permission_action_id: 1, permission_section_id: 19, value: false, name: "View Sales", section_id: 4},

  {permission_action_id: 1, permission_section_id: 20, value: false, name: "View Order and Order Files", section_id: 4},

  {permission_action_id: 1, permission_section_id: 21, value: false, name: "View Invoices", section_id: 4},

  {permission_action_id: 1, permission_section_id: 22, value: false, name: "View Items", section_id: 4},

  {permission_action_id: 1, permission_section_id: 23, value: false, name: "View Administration", section_id: 5},
  {permission_action_id: 3, permission_section_id: 23, value: false, name: "Edit Administration", section_id: 5}
]

permission_action_permission_section_attributes.each do |attributes|
  PermissionActionPermissionSection.where(attributes).first_or_create
end


Rake::Task["new_seed:insert_in_discount_offer"].execute
Rake::Task["new_seed:insert_in_discount_type"].execute
Rake::Task["new_seed:insert_in_discount_offer_type"].execute
Rake::Task["new_seed:insert_in_deposit_type"].execute
Rake::Task["new_seed:insert_in_status"].execute
Rake::Task["new_seed:insert_into_payment_with"].execute
