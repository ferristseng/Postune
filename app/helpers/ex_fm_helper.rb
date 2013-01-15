module ExFmHelper

	def exfm_image?(image)
		!image.blank? && image != "None"
	end

end