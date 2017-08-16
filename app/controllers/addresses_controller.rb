class AddressesController < ApplicationController
	before_action :set_address, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def new
		@brands = Brand.active
		@address = current_user.addresses.build
	end

	def create
		@address = current_user.addresses.build(address_params)
		if @address.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @address.update(address_params)
			redirect_to @address
		else
			render 'edit'
		end

	end

	def destroy
		@address.destroy
		redirect_to root_path, notice: "Successfully deleted post"
	end 

	private

	def address_params
		params.require(:address).permit(:first_name, :last_name, :street_address, :street_address2, :city, :state, :zipcode, :country)
	end

	def set_address
		@address = Address.find(params[:id])
	end
end
