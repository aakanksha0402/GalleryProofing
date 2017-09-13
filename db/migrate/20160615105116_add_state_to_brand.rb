class AddStateToBrand < ActiveRecord::Migration
  def change
    add_reference :brands, :state_province, index: true, foreign_key: true
  end
end
