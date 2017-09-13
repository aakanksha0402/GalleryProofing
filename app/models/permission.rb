class Permission < ActiveRecord::Base
  belongs_to :permission_action_permission_section
  belongs_to :user
end
