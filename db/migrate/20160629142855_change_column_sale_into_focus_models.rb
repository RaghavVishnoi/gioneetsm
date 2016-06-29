class ChangeColumnSaleIntoFocusModels < ActiveRecord::Migration
  def change
  	change_column :focus_models,:sale,:int,limit: 10
  end
end
