class Api::V1::VersionsController < ApplicationController
	skip_before_action :authenticate_user

	def index
		version = VERSION
	    render :json => {result: true,version: version}
	end

end