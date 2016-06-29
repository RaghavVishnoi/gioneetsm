class ChangeColumnValueTargetIntoTargets < ActiveRecord::Migration
  def change
  	change_column :targets,:value_target,:string
  end
end
