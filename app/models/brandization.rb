class Brandization < ActiveRecord::Base
	belongs_to :post
	belongs_to :brand
end
