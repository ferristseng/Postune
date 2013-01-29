module DropdownHelper
	
	def dropdown(label, items = nil, &block)
		caret_span = content_tag(:span, "", { :class => "caret" })
		caret_div = content_tag(:div, "", { :class => "caret" })
		dropdown_toggle = link_to(raw("#{label}#{caret_span}"), "#", { :class => "dropdown-toggle"})
		dropdown_items = ""
		if block.present?
			dropdown_items = capture(&block)
		else
			items.each { |e| dropdown_items += dropdown_link(e) }
		end
		dropdown_list = content_tag(:ul, raw(dropdown_items), { :class => "dropdown-list" })
		dropdown_inner = content_tag(:div, raw(caret_div) + raw(dropdown_list), { :class => "dropdown-inner" })
		raw content_tag(:div, raw(dropdown_toggle) + raw(dropdown_inner), { :class => "dropdown", "data-toggle" => "dropdown" })
	end

	def dropdown_link(content)
		content_tag(:li, raw(content), { :class => "dropdown-element" })
	end

	def dropdown_separator
		content_tag(:li, "", { :class => "dropdown-separator" })
	end

end