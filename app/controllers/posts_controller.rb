class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy, :favorite, :like]
	load_and_authorize_resource :only => [:show, :new, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	#impressionist :actions => [:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]
	has_scope :brand

	respond_to :html, :json, :js

	def seller
		@posts = Post.all.order("created_at DESC")
		
	end

	def index
		@brands = Brand.active
		
		@posts = apply_scopes(Post).hat.order("created_at DESC")
		#@posts = @posts.brand(params[:brand]) if params[:brand].present?

		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end
	end

	def show
		@brands = Brand.active

		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end

	    @randomposts = Post.where.not(id: @post).order("RANDOM()").take(6)
	end

	def new
		@brands = Brand.active
		@post = current_user.posts.build
	end

	def create
		@brands = Brand.active
		@post = current_user.posts.build(post_params)
		
		if @post.save
			redirect_to action: "index"
		else
			render 'new'
		end
	end

	def edit
		@brands = Brand.active
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end

	end

	def destroy
		@post.destroy
		redirect_to root_path, notice: "Successfully deleted post"
	end

	def favorite
    if user_signed_in?

      type = params[:type]
      if type == "favorite"
        current_user.favorites << @post

        respond_to do |format|
          format.html {redirect_to :back}
          format.json { render json: {  count: @post.favorited_by.count} }
          format.js { render :layout => false }
        end

      elsif type == "unfavorite"
        current_user.favorites.delete(@post)

        respond_to do |format|
          format.html {redirect_to :back}
          format.json { render json: {  count: @post.favorited_by.count } }
          format.js { render :layout => false }
        end

      else
        # Type missing, nothing happens
        redirect_to :back, notice: 'Nothing happened.'
      end

    else
        redirect_to new_user_registration_path
    end
  end

	def like
    if user_signed_in?

      type = params[:type]
      if type == "like"
        current_user.likes << @post

        respond_to do |format|
          format.html {redirect_to :back}
          format.json { render json: {  count: @post.liked_by.count} }
          format.js { render :layout => false }
        end

      elsif type == "unlike"
        current_user.likes.delete(@post)

        respond_to do |format|
          format.html {redirect_to :back}
          format.json { render json: {  count: @post.liked_by.count } }
          format.js { render :layout => false }
        end

      else
        # Type missing, nothing happens
        redirect_to :back, notice: 'Nothing happened.'
      end

    else
        redirect_to new_user_registration_path
    end
  end  

	private

	def post_params
		params.require(:post).permit(:brand, :title, :link, :price, :image, :image2, :image3, :category, :shipping_price, :quantity, :member_discount, :brand_id, brand_ids: [])
	end

	def set_post
		@post = Post.find(params[:id])
	end

	 def find_post
      user = User.find_by_username(params[:id])
    end
end
