class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :hb_id, index: true
      t.string :vendor, index: true
      t.string :title, index: true
      t.string :description
      t.string :imageUrl
      t.string :previewImageUrl
      t.string :slug
      t.jsonb :barcodes
      t.string :barcode
      t.string :unitType
      t.string :soldBy
      t.float :amountPerUnit, index: true
      t.string :size
      t.string :status
      t.string :imageUrlBasename
      t.string :currency
      t.datetime :promotionStartsAt
      t.datetime :promotionEndsAt
      t.float :maxQuantity
      t.boolean :customerNotesEnabled
      t.float :price, index: true
      t.float :normalPrice, index: true
      t.string :nutritionalInfo
      t.string :productBrand
      t.string :productInfo
      t.string :packingSize, index: true
      t.string :descriptionHtml
      t.string :countryOfOrigin
      t.jsonb :tags
      t.boolean :alcohol
      t.timestamps
    end
  end
end
