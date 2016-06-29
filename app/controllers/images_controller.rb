class ImagesController < ApplicationController

	def create
		@image = Image.new image_params
		if @image.save
			image_url = ImageSerializer.new(@image, :root => false)
			render :json => {image: @image}
		else

		end	
	end

	def image_params
		params.require(:image).permit(:lat,:lng,:image)
	end

end