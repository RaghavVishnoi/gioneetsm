require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.cron '5 0 * * *' do
	end_time = Time.now
	begin_time = end_time.yesterday.strftime("%Y-%m-%d")
	end_time = end_time.strftime("%Y-%m-%d")
 	Zsale.update(ZSALES,begin_time,end_time)
end

scheduler.cron '15 0 * * *' do
	end_time = Time.now.end_of_day
	begin_time = '06-20-2016'#end_time.yesterday.begining_of_day.strftime("%Y-%m-%d")
	end_time = end_time.strftime("%m-%d-%Y")
	Zuser.update(ZUSERS,begin_time,end_time)
end
 