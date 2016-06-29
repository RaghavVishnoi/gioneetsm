class ChangeColumnValueTargetIntoTargets < ActiveRecord::Migration
  def change
  	change_column :targets,:value_target,:int,limit: 10
  end
end
