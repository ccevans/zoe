class Exhibition < ActiveRecord::Base
	belongs_to :user
	has_many :posts

	has_attached_file :image, :styles => { :large => "1600x800#", :medium => "800x400#", :thumb => "400x200#" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
