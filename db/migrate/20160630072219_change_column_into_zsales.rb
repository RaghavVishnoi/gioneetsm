class ChangeColumnIntoZsales < ActiveRecord::Migration
  def change
  	change_column :zsales,:address,:text
  end
end
