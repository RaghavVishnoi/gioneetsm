class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
    	t.string :mum
    	t.string :rds
    	t.string :fos
    	t.integer :value_target
    	t.integer :volume_target
    	t.text :plan_remarks
    	t.text :review_remarks
      	t.timestamps null: false
    end
  end
end
