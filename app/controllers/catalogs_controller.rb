class CatalogsController < ApplicationController
  def update_description
    puts params
    @item_description=Catalog.find_by(id: params[:catalog][:id]).update(discription: params[:catalog][:discription])
    redirect_to show_group_groups_url(id: params[:pricing_id])
  end

  def create
    @group = Group.find(params[:div_val1])
    #Saves the resoultion
    @search_item_list = ItemList.find_by(size_one: params[:catalog][:print_size_one],size_two: params[:catalog][:print_size_two])
    puts "_____________________________"
    puts @search_item_list.present?
    puts "_____________________________"
    unless @search_item_list.present?
      @item_list = ItemList.new(size_one: params[:catalog][:print_size_one],size_two: params[:catalog][:print_size_two],group_id: @group.id,group_name: @group.name)
      @item_list.save
    end

    @fix_group_id=Group.find_by(id: params[:div_val1])
    @custom_catalog=Catalog.new(catalog_params)
    @custom_catalog.fix_group_id= @fix_group_id.fix_group_id
    @custom_catalog.checked=true
    @custom_catalog.catalog_type=params[:type]
    @custom_catalog.group_id=params[:div_val1]
    if @search_item_list.present?
      @custom_catalog.item_list_id = @search_item_list.id
    else
      @custom_catalog.item_list_id = @item_list.id
    end
    if params[:catalog][:digital_media_price].present?
      puts "PRESENT"
      puts "PRESENT"
      @custom_catalog.is_galleryproofing = true
    else
      puts "NOT PRESENT"
      puts "NOT PRESENT"
      @custom_catalog.is_galleryproofing = false
    end
    @custom_catalog.save
    if @fix_group_id.fix_group_id == 2
      unless params[:self].present?
        puts @custom_catalog.id
        @dmp = DigitalMediaPrice.new(indiviual_photo_price: params[:catalog][:digital_media_price][:indiviual_photo_price],all_album_photo_price: params[:catalog][:digital_media_price][:all_album_photo_price],all_gallery_photo_price: params[:catalog][:digital_media_price][:all_gallery_photo_price])
        @dmp.catalog_id = @custom_catalog.id
        if params[:catalog][:digital_media_price][:indiviual_price_active].present?
          @dmp.individual_price_active = true
        end
        @dmp.save
      end
    end
    redirect_to show_group_groups_path(id: params[:catalog][:pricing_id])
  end


  private

  def catalog_params
    params.require(:catalog).permit(:pricing_id,:catalog_type,:group_id,:fix_group_id,:checked,:discription,:cost,:price,:profit,:shipping_charge,:shipping_charge_apply,:print_size_one,:print_size_two,:depth,:sub_item_name,:resolution, digital_media_price_attributes: [])
  end

  def digital_media_params
    params.require(:digital_media_price).permit(:individual_photo_price,:individual_price_active,:all_album_photo_price,:all_album_price_active,:all_gallery_photo_price,:all_gallery_price_active)
  end
end
