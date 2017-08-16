class PagesController < ApplicationController
  def home
  	@brands = Brand.active
  end

  def about
  	@brands = Brand.active
  end

  def admin
  	@brands = Brand.active
  	@posts = Post.all.order("created_at DESC")

  end

  def subscription
  	@brands = Brand.active
  end

  def register
  	@brands = Brand.active
  end
  
	def tees
		@brands = Brand.active
		@posts = Post.tee.order("created_at DESC")
		
		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end
	end

	def hats
		@brands = Brand.active
		@posts = Post.hat.order("created_at DESC")
		
		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end
	end

	def jackets
		@brands = Brand.active
		@posts = Post.jacket.order("created_at DESC")
		
		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end
	end

	def accessories
		@brands = Brand.active
		@posts = Post.accessory.order("created_at DESC")
		
		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end
	end
end
