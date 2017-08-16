class Brand < ActiveRecord::Base
	belongs_to :user
	has_many :brandizations
	has_many :posts, through: :brandizations

	validates_uniqueness_of :brandname
	validates :brandname, format: { with: /\A[a-zA-Z0-9]+\Z/ }
	validates :email, presence: true
	validates_length_of :brandname, :minimum => 2, :maximum => 15

	scope :draft, ->{where(published_at: nil)}
	scope :active, ->{where.not(published_at: nil).where("published_at <= ?", Time.now.in_time_zone("Eastern Time (US & Canada)"))}	

	 attr_accessor :status

	 before_validation :clean_up_status
	 def clean_up_status
	 	self.published_at = case status
	 						when "Draft"
	 							nil
	 						when "Active"
	 							Time.zone.now
	 						else
	 							published_at
	 						end
	 	true
	 end
end
