class AddAttachmentWatermarkImageWatermarkSampleImageToWatermarks < ActiveRecord::Migration
  def self.up
    change_table :watermarks do |t|
      t.attachment :watermark_image
      t.attachment :watermark_sample_image
    end
  end

  def self.down
    remove_attachment :watermarks, :watermark_image
    remove_attachment :watermarks, :watermark_sample_image
  end
end
