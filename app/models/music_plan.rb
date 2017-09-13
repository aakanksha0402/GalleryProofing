class MusicPlan < ActiveRecord::Base
  has_one :plan_billing, dependent: :destroy
  belongs_to :category
end
