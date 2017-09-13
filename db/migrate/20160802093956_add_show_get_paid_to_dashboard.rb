class AddShowGetPaidToDashboard < ActiveRecord::Migration
  def change
    add_column :dashboards, :show_get_paid, :boolean
  end
end
