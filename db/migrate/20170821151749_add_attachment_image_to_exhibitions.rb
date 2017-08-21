class AddAttachmentImageToExhibitions < ActiveRecord::Migration
  def self.up
    change_table :exhibitions do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :exhibitions, :image
  end
end
