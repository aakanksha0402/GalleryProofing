class LabelPhoto < ActiveRecord::Base
  belongs_to :label
  belongs_to :photo
end
