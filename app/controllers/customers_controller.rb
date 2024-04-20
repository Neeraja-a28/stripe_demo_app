class CustomersController  < ApplicationController
	def index
		@customers = Customer.all
	end

	def show
		@customer = Customer.find(params[:id])
	end

	def new
		@customer = Customer.new
	end

	def create
		customer = Customer.new(customer_params) 
        stripe_customer = StripeService.new.find_or_create_stripe_customer(customer)
        
        puts "found stripe customer id: #{stripe_customer}"
        if stripe_customer.present? && customer.present?
            customer.save
        	redirect_to customer
        else
        	render :new, status: :unprocessable_entity
        end

	end

	private
	def customer_params
      params.require(:customer).permit(:full_name, :email, :contact_number)
	end
end