module ApplicationHelper

	def title
		base_title = "Postune | "
		@title.nil? ? "#{base_title} Untitled Page" : "#{base_title} #{@title}"
	end

	def every(collection, num)
		collection.each_slice(num).to_a
	end

	def required_field(object, field)
		object.errors.messages[field].present? ? raw("<div class='inline-error'><div class='inline-error-caret'></div><div class='inline-error-body'>#{object.class.human_attribute_name(field)} #{object.errors.messages[field][0]}</div></div>") : ""
	end

end
