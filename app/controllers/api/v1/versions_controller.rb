class Api::V1::VersionsController < ApplicationController

	def index
		version = VERSION
	    render :json => {result: true,version: version}
	end

end