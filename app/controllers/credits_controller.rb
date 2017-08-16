class CreditsController < ApplicationController

	def index
		@brands = Brand.active
		@credits = Credit.all
	end



	def use_credit
		@credit = current_user.credits.last
		
		@order = Order.find(params[:order_id])
		@credit.order_id = @order.id

		@credit.creditavailable = false

		current_user.credits << @order
	end
end
