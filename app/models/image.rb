class Image < ActiveRecord::Base

	mount_uploader :image, ImageUploader
  
 	belongs_to :object, :polymorphic => true

 	validate :lat
	validate :lng
	validate :image
	validate :object_type

	def self.find_prev_path(user)
    	if user.profile_path != nil
            path = user.profile_path.reverse.split('/',2)
    	end
    end

    def self.delete_directory(user)
        FileUtils.rm_rf('public'+find_prev_path(user)[1].reverse) if find_prev_path(user) != nil
    end

end
