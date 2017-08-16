class AddAttachmentImage2ToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :image2
    end
  end

  def self.down
    remove_attachment :posts, :image2
  end
end
