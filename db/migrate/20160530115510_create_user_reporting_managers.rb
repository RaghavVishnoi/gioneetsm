class CreateUserReportingManagers < ActiveRecord::Migration
  def change
    create_table :user_reporting_managers do |t|
      t.integer :user_id
      t.integer :reporting_manager_id
      t.timestamps null: false
    end
    add_foreign_key :user_reporting_managers,:users,column: :user_id
    add_foreign_key :user_reporting_managers,:users,column: :reporting_manager_id
  end
end
