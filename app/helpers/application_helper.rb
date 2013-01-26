module ApplicationHelper

	def title
		base_title = "Postune | "
		@title.nil? ? "#{base_title} Untitled Page" : "#{base_title} #{@title}"
	end

	def every(collection, num)
		collection.each_slice(num).to_a
	end

	def dropdown(label, items)
		caret_span = content_tag(:span, "", { :class => "caret" })
		caret_div = content_tag(:div, "", { :class => "caret" })
		dropdown_toggle = link_to(raw("#{label}#{caret_span}"), "#", { :class => "dropdown-toggle"})
		dropdown_items = ""
		items.each { |e| dropdown_items += content_tag(:li, raw(e), { :class => "dropdown-element" }) }
		dropdown_list = content_tag(:ul, raw(dropdown_items), { :class => "dropdown-list" })
		dropdown_inner = content_tag(:div, raw(caret_div) + raw(dropdown_list), { :class => "dropdown-inner" })
		raw content_tag(:div, raw(dropdown_toggle) + raw(dropdown_inner), { :class => "dropdown", "data-toggle" => "dropdown" })
	end

	def required_field(object, field, full = true)
		error = full ? "#{object.class.human_attribute_name(field)} #{object.errors.messages[field][0]}" : object.errors.messages[field][0]
		if object.errors.messages[field].present? 
			raw("<div class='inline-error'>
						<div class='inline-error-caret'></div>
						<div class='inline-error-body'>
							#{error}
						</div>
					</div>")
		end
	end

end
