class AddColumnPaymentIssueToSalesBeat < ActiveRecord::Migration
  def change
    add_column :sales_beats,:payment_issue,:boolean
  end
end
