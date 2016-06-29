class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
    	t.integer :user_id
    	t.string :user_type
    	t.text :message
    	t.string :activty_type
      	t.timestamps null: false
    end
    add_foreign_key :user_activities,:users
  end
end
