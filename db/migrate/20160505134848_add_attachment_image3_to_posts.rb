class AddAttachmentImage3ToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :image3
    end
  end

  def self.down
    remove_attachment :posts, :image3
  end
end
