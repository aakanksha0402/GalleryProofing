class FixGroup < ActiveRecord::Base
	has_many :groups, dependent: :destroy
	has_many :item_lists,primary_key: 'id',foreign_key: 'fix_group_id'
end
