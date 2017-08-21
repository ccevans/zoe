class ExhibitionsController < ApplicationController
	before_action :find_exhibition, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

def index
	@brands = Brand.active
	@exhibitions = Exhibition.all.order("created_at DESC")
end

def show
	@brands = Brand.active
end

def new
	@brands = Brand.active
	@exhibition = current_user.exhibitions.build
end

def create
	@exhibition = current_user.exhibitions.build(exhibition_params)

	if @exhibition.save
		redirect_to @exhibition
	else
		render 'new'
	end
end

def edit
	@brands = Brand.active
end

def update
	if @exhibition.update(exhibition_params)
		redirect_to @exhibition
	else
		render 'edit'
	end
end

def destroy
	@exhibition.destroy
	redirect_to root_path
end

private

	def find_exhibition
		@exhibition = Exhibition.find(params[:id])
	end

	def exhibition_params
		params.require(:exhibition).permit(:title, :description, :image)
	end

end
