module ApplicationHelper

	def title
		base_title = "Postune | "
		@title.nil? ? "#{base_title} Untitled Page" : "#{base_title} #{@title}"
	end

end
