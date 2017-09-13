class PlanBilling < ActiveRecord::Base
  belongs_to :data_plan
  belongs_to :music_plan
  belongs_to :user
end
