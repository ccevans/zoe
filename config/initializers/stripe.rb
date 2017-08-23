
require "stripe"

Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLIC'],
  :secret_key      => ENV['STRIPE_SECRET']
}

#Stripe.api_key = Rails.configuration.stripe[:secret_key]

Stripe.api_key = "sk_test_OpttamLiuDjKxwqjCuVfURIX"

# config/initializers/stripe.rb
#Stripe.api_key = ENV['STRIPE_SECRET'] # e.g. sk_live_1234

class RecordCharges
	def call(event)
		charge = event.data.object
		#Look up the user in our database
		user = User.find_by(stripe_id: charge.customer)

	    c = user.charges.where(stripe_id: charge.id).first_or_create
	    c.update(
	    	amount: charge.amount,
	    	card_last4: charge.source.last4,
	    	card_type: charge.source.brand,
	    	card_exp_month: charge.source.exp_month,
	    	card_exp_year: charge.source.exp_year
	    	)
	end
end

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', RecordCharges.new
    # Define subscriber behavior based on the event object
   
end

class CreateCredit
	def call(event)
		invoice = event.data.object

		if (invoice.lines.data[0].plan.id == 'monthly')
			user = User.find_by(stripe_id: invoice.customer)

			c = user.credits.where(stripe_id: invoice.id).first_or_create
			c.update(
				creditactive: true
				)
		end

	end
end

StripeEvent.configure do |events|
  events.subscribe 'invoice.payment_succeeded', CreateCredit.new
    # Define subscriber behavior based on the event object
   
end

