class UserReportingManager < ActiveRecord::Base
	belongs_to :user,foreign_key: 'user_id'
	belongs_to :user,foreign_key: 'reporting_manager_id'
end
