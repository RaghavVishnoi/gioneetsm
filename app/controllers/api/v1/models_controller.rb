class Api::V1::ModelsController < ApplicationController

	def index
		@models = Model.all.pluck(:name)
		render :json => {result: true,object: @models}
	end

end