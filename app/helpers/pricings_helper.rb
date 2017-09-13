module PricingsHelper
  def group_wise_catalogs(print_group, group_id)
    @catalogs = Catalog.where("group_id = ? AND print_size_one = ? AND print_size_two = ? ", group_id,print_group[0], print_group[1] )
    return @catalogs
  end
end
