require 'stripe'

class StripeService
	def initialize()
		Stripe.api_key = ENV['STRIPE_SECRET_KEY']
	end

	def find_or_create_stripe_customer(customer)
		if customer.stripe_customer_id.present?
			stripe_customer_id = Stripe::Customer.retrieve(id: customer.stripe_customer_id)
		else
			stripe_customer_id = Stripe::Customer.create({
 				                    name: customer.full_name,
  				                    email: customer.email,
  				                    phone: customer.contact_number
				                    })
		end
		stripe_customer_id
	end

    # create card token in stripe
	def create_stripe_card_token(params)
		Stripe::Token.create({
  			card: {
    		 	number: params[:card_number].to_s,
    			exp_month: params[:exp_month],
    			exp_year: params[:exp_year],
    			cvc: params[:cvv],
  			},
		})
	end

   # create stripe customer card
	def create_stripe_customer_card(params,  customer)
		token = create_stripe_card_token(params)
		Stripe::Customer.create_source(
			customer.id,
			{source: token.id}
			)

	end
end