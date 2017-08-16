class Post < ActiveRecord::Base
	belongs_to :user
	has_many :orders
	#is_impressionable :counter_cache => true, :column_name => :counter_cache, :unique => :request_hash
	has_many :brandizations
	has_many :brands, through: :brandizations

	validates :user_id, presence: true
	validates_presence_of :slug
	validates_presence_of :slug2

	has_attached_file :image, :styles => { :large => "1600x1200#", :medium => "800x600#", :thumb => "400x300#" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	has_attached_file :image2, :styles => { :large => "1600x1200#", :medium => "800x600#", :thumb => "400x300#" }
	validates_attachment_content_type :image2, :content_type => /\Aimage\/.*\Z/

	has_attached_file :image3, :styles => { :large => "1600x1200#", :medium => "800x600#", :thumb => "400x300#" }
	validates_attachment_content_type :image3, :content_type => /\Aimage\/.*\Z/

	# Favorited by users
	has_many :favorite_posts # just the 'relationships'
	has_many :favorited_by, through: :favorite_posts, source: :user

	# Liked by users
	has_many :like_posts # just the 'relationships'
	has_many :liked_by, through: :like_posts, source: :user

	scope :brand, -> brand { where("brand = ?", :brand) }

	scope :tee, ->{ where(:category => "Tee") }
	scope :hat, ->{ where(:category => "Hat") }
	scope :jacket, ->{ where(:category => "Jacket") }
	scope :accessory, ->{ where(:category => "Accessory") }

	def slug
	   	title.to_s.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, '') 
	end

	def slug2
		brand.to_s.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, '')
	end

	def to_param
    	"#{id}-#{slug2}-#{slug}"
  	end


end
