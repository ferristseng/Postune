module SocialHelper

	def link_to_oauth_sign_in(label, link, icon)
		raw link_to(raw("#{content_tag(:span, '', :id => icon, :class => "social-icon")} #{content_tag(:span, label)}"), link, :class => "social-link")
	end

end
