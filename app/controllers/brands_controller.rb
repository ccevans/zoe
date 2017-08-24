class BrandsController < ApplicationController
before_action :set_brand, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :only => [:show, :new, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  	@brands = Brand.active
  end

  def show
    @brands = Brand.active
		@posts = @brand.posts.order("created_at DESC")

		if user_signed_in?
	      @favorites = current_user.favorites
	      @likes = current_user.likes
	    end
  end

  def new
    @brands = Brand.active
    @brand = current_user.brands.build
  end

  def create
    @brand = current_user.brands.build(brand_params)

    account = Stripe::Account.create(
      :country => "US", 
      :email => @brand.email,
      :business_name => @brand.title,
      :type => 'custom',
      :legal_entity => {
        :type => "individual", 
        :first_name => @brand.first_name, 
        :last_name => @brand.last_name, 
        :address => {
          :line1 =>  @brand.street_address, 
          :city =>  @brand.city, 
          :state =>  @brand.state, 
          :postal_code =>  @brand.postal_code
          }, 
        :dob => {
          :day =>  @brand.birth_day, 
          :month =>  @brand.birth_month, 
          :year =>  @brand.birth_year
          }, 
        :ssn_last_4 =>  @brand.ssn_last_4 
      }, 
      :tos_acceptance => {
        :date => Time.now.to_i, 
        :ip => request.remote_ip
    })

    account.external_accounts.create(
      :external_account => params[:stripeToken]
    )

    @brand.account_id = account.id
    @brand.secret_key = account.keys.secret
    @brand.publishable_key = account.keys.publishable


    if @brand.save

      flash[:notice] = "Thanks for registering your art account!  We will contact shortly."

      UserNotifier.send_account_setup_email(current_user).deliver

      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @brands = Brand.active

  end

  def update
  	if @brand.update(brand_params)
  		redirect_to brands_path
  	else
  		render :edit
  	end
  end

  def destroy
  	@brand.destroy
  	redirect_to brands_path
  end


 private
	 def set_brand
	 	@brand = Brand.find_by_brandname(params[:id])
	 end

	 def brand_params
	 	params.require(:brand).permit(:title, :description, :brandname, :first_name, :last_name, :email, :phone, :website, :street_address, :street_address_line2, :city, :state, :postal_code, :birth_day, :birth_month, :birth_year, :ssn_last_4)
	 end

   def find_brand
      user = User.find_by_username(params[:id])
    end
end
