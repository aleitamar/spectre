class CreateThumbs < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.string :uid
      t.string :signature, index: true

      t.timestamps null: false
    end
  end
end
