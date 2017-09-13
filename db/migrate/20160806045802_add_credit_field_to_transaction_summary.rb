class AddCreditFieldToTransactionSummary < ActiveRecord::Migration
  def change
    add_column :transaction_summaries, :credit, :decimal, default: 0.00
  end
end
