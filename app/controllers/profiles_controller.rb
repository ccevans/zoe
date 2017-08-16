class ProfilesController < ApplicationController
	before_action :find_post, only: [:show]
	respond_to :html, :json, :js
  	before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all.order("created_at ASC").paginate(page: params[:page], per_page: 50)
    @user = User.find_by_username(params[:id])
    @brands = Brand.active
  end

  def show
    @brands = Brand.active
  	@user = User.find_by_username(params[:id])

    if user_signed_in?
      @favorites = current_user.favorites
      @likes = current_user.likes
    end

  	if @user
      @posts = @user.favorites.all.order("created_at ASC")

      render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end


  end



private

	def find_post
		@user = User.find_by_username(params[:id])
	end
end
