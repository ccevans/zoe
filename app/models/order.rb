class Order < ActiveRecord::Base
	belongs_to :post
	belongs_to :buyer, class_name: "User"
	belongs_to :seller, class_name: "User"

	has_one :credit
	has_one :address

	def ordernumber
	   	"CAP-#{id}"
	end
end
