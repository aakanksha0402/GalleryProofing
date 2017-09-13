class TransactionSummary < ActiveRecord::Base
  belongs_to :user

  default_scope { order("id ASC") }
end
