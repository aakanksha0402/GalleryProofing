module BrandsHelper
   def get_state(brand_country_id)
     @country = Country.find(brand_country_id)
     @state = @country.state_provinces
   end
end
