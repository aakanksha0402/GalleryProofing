class AddFieldsToContact < ActiveRecord::Migration
  def change
    add_reference :contacts, :country, index: true, foreign_key: true
    add_reference :contacts, :state_province, index: true, foreign_key: true
  end
end
