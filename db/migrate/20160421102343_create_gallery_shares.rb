class CreateGalleryShares < ActiveRecord::Migration
  def change
    create_table :gallery_shares do |t|
      t.string :recipient
      t.string :subject
      t.string :headline
      t.string :buttontext
      t.string :message
      t.references :email_template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
