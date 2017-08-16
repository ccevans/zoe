module ApplicationHelper
	def card_fields_class
		if user_signed_in?
			"nodisplay" if current_user.card_last4?
		end
	end

	def address_fields_class
		if user_signed_in?
			"nodisplay" if current_user.street_address?
		end
	end

	def subscription_header_class
		"nodisplay" if current_user_subscribed?
	end

	def address_fields_required
		if user_signed_in?
			return true if current_user.street_address?
		end
	end

	def card_fields_required
		if user_signed_in?
			return true if current_user.card_last4?
		end
	end
end
