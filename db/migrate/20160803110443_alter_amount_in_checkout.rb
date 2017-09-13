class AlterAmountInCheckout < ActiveRecord::Migration
  def up
        change_column :checkouts, :amount, 'decimal USING CAST(amount AS decimal)'
    end

    def down
        change_column :checkouts, :amount, :string
    end
end
