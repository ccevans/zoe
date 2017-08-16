class OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	

	respond_to :html, :js, :json
	
	def sales
		@brands = Brand.active
		@orders = Order.all.where(seller: current_user).order("created_at DESC")
		
		

	end

	def purchases
		@brands = Brand.active
		@orders = Order.all.where(buyer: current_user).order("created_at DESC")
		
	end

	def index
		@brands = Brand.active
		@orders = Order.all
	end

	def new
		@brands = Brand.active
		@order = Order.new

		@post = Post.find(params[:post_id])
	end

	def create
		@order = Order.new(order_params)

		if user_signed_in?
			@order.buyer_id = current_user.id
		else
			@order.buyer_id = nil
		end

		@post = Post.find(params[:post_id])
		@order.post_id = @post.id
		@seller = @post.user
		@order.seller_id = @seller.id
		@brand = Brand.find(@post.brand_id)

		if user_signed_in?
			if (!current_user.street_address? || @order.address_default == true)
				current_user.first_name = @order.first_name
				current_user.last_name = @order.last_name
				current_user.street_address = @order.street_address
				current_user.street_address2 = @order.street_address2
				current_user.city = @order.city
				current_user.state = @order.state
				current_user.zipcode = @order.zipcode
				current_user.country = @order.country
				current_user.save!
			end


			if @order.current_address == true
				@order.first_name = current_user.first_name
				@order.last_name = current_user.last_name
				@order.street_address = current_user.street_address
				@order.street_address2 = current_user.street_address2
				@order.city = current_user.city
				@order.state = current_user.state
				@order.zipcode = current_user.zipcode
				@order.country = current_user.country
				
			else
				address = Address.new(
					:user_id => current_user.id,
					:first_name => @order.first_name,
					:last_name => @order.last_name,
					:street_address => @order.street_address,
					:street_address2 => @order.street_address2,
					:city => @order.city,
					:state => @order.state,
					:zipcode => @order.zipcode,
					:country => @order.country
					)
				address.save!
			end
		end


		if @post.quantity > 0
			if params[:commit] == 'A'


				if user_signed_in? && current_user.stripe_id?
					customer = Stripe::Customer.retrieve(current_user.stripe_id)

					if current_user_subscribed?

						begin
							charge = Stripe::Charge.create({
								:amount => ((@post.price.to_i - @post.member_discount.to_i + @post.shipping_price.to_i) * 100).floor,
								:currency => "usd",
								:customer => customer.id,
								:description => @post.title,
								:metadata => {"order_id" => @order.ordernumber},
								:destination => {
									:amount => (((@post.price.to_i - @post.member_discount.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
									:account => @brand.account_id
								}
							})
							flash[:notice] = "Thanks for ordering!"

							quantity_update
						
						rescue Stripe::CardError => e
							flash[:alert] = e.message
						rescue => e
							flash[:alert] = "Error occured with order placement. Try Again."
						end

					else
						begin
							charge = Stripe::Charge.create({
								:amount => ((@post.price.to_i + @post.shipping_price.to_i) * 100).floor,
								:currency => "usd",
								:customer => customer.id,
								:description => @post.title,
								:metadata => {"order_id" => @order.ordernumber},
								:destination => {
									:amount => (((@post.price.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
									:account => @brand.account_id
								}
							})
							flash[:notice] = "Thanks for ordering!"

							quantity_update
						rescue Stripe::CardError => e
							flash[:alert] = e.message
						rescue => e
							flash[:alert] = "Error occured with order placement. Try Again."					
						end

					end
				else	

					customer = Stripe::Customer.create(email: current_user.email, source: params[:stripeToken])

					current_user.stripe_id = customer.id

					if params[:card_last4]
					current_user.card_last4 = params[:card_last4]
					current_user.card_exp_month = params[:card_exp_month]
					current_user.card_exp_year = params[:card_exp_year]
					current_user.card_type = params[:card_brand]

					end

					current_user.save!

					if current_user_subscribed?

						begin
							charge = Stripe::Charge.create({
								:amount => ((@post.price.to_i - @post.member_discount.to_i + @post.shipping_price.to_i) * 100).floor,
								:currency => "usd",
								:customer => customer.id,
								:description => @post.title,
								:metadata => {"order_id" => @order.ordernumber},
								:destination => {
									:amount => (((@post.price.to_i - @post.member_discount.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
									:account => @brand.account_id
								}
							})
							flash[:notice] = "Thanks for ordering!"

							quantity_update
						rescue Stripe::CardError => e
							flash[:alert] = e.message
						rescue => e
							flash[:alert] = "Error occured with order placement. Try Again."
						end

					else
						begin
							charge = Stripe::Charge.create({
								:amount => ((@post.price.to_i + @post.shipping_price.to_i) * 100).floor,
								:currency => "usd",
								:customer => customer.id,
								:description => @post.title,
								:metadata => {"order_id" => @order.ordernumber},
								:destination => {
									:amount => (((@post.price.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
									:account => @brand.account_id
								}
							})
							flash[:notice] = "Thanks for ordering!"

							quantity_update
						rescue Stripe::CardError => e
							flash[:alert] = e.message
						rescue => e
							flash[:alert] = "Error occured with order placement. Try Again."					
						end

					end
				end

			elsif params[:commit] == 'B'

				use_credit

				quantity_update



			elsif params[:commit] == 'D'
					customer = Stripe::Customer.create(
						:source => params[:stripeToken],
						:email => @order.email
						)

					begin
						charge = Stripe::Charge.create({
							:amount => ((@post.price.to_i + @post.shipping_price.to_i) * 100).floor,
							:currency => "usd",
							:customer => customer.id,
							:description => @post.title,
							:metadata => {"order_id" => @order.ordernumber},
							:destination => {
								:amount => (((@post.price.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
								:account => @brand.account_id
							}
						})
						flash[:notice] = "Thanks for ordering!"

						quantity_update
					rescue Stripe::CardError => e
						flash[:alert] = e.message
					rescue => e
						flash[:alert] = "Error occured with order placement. Try Again."					
					end

			else

				if user_signed_in?

					customer = Stripe::Customer.retrieve(current_user.stripe_id)
					card = customer.sources.create(source: params[:stripeToken])
					card = customer.sources.retrieve(card.id)

					if current_user_subscribed?
						begin
							charge = Stripe::Charge.create({
								:amount => ((@post.price.to_i - @post.member_discount.to_i + @post.shipping_price.to_i) * 100).floor,
								:currency => "usd",
								:customer => customer.id,
								:description => @post.title,
								:metadata => {"order_id" => @order.ordernumber},
								:destination => {
									:amount => (((@post.price.to_i - @post.member_discount.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
									:account => @brand.account_id
								}
							})
							flash[:notice] = "Thanks for ordering!"

							quantity_update
						rescue Stripe::CardError => e
							flash[:alert] = e.message
						rescue => e
							flash[:alert] = "Error occured with order placement. Try Again."
						end

					else
						begin
						charge = Stripe::Charge.create({
							:amount => ((@post.price.to_i + @post.shipping_price.to_i) * 100).floor,
							:currency => "usd",
							:customer => customer.id,
							:description => @post.title,
							:metadata => {"order_id" => @order.ordernumber},
							:destination => {
								:amount => (((@post.price.to_i)*(0.7) + @post.shipping_price.to_i) * 100).floor,
								:account => @brand.account_id
							}
						})
							flash[:notice] = "Thanks for ordering!"

							quantity_updates
						rescue Stripe::CardError => e
							flash[:alert] = e.message
						rescue => e
							flash[:alert] = "Error occured with order placement. Try Again."
						end
					end

				end

			end
		end

		if @order.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def use_credit
		
		@credit = current_user.credits.where(creditactive: true).last

		@order.credit_id = @credit.id

		@credit.creditactive = false
		@credit.order_id = @order.id
		@credit.save

		flash[:notice] = "Thanks for ordering!"


	end

  	def quantity_update

  		@post = Post.find(params[:post_id])
  		if @post.quantity > 0
  			@post.quantity = @post.quantity - 1
  		end
  		@post.save

  		
	end



private

	def order_params
		params.require(:order).permit(:ordernumber, :address_id, :first_name, :last_name, :street_address, :street_address2, :city, :state, :country, :zipcode, :address_default, :current_address, :email)
	end

	def set_order
		@order = Order.find(params[:id])
	end

end
