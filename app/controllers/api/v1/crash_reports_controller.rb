class Api::V1::CrashReportsController < ApplicationController

	skip_before_action :authenticate_user


	def index
		CrashReportMailer.report(params[:message]).deliver_now
		render :json => {result: true}
	end

end