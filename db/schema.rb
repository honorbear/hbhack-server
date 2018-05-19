# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_05_19_075609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.integer "vendor_product_id"
    t.string "vendor"
    t.string "title"
    t.string "description"
    t.string "imageUrl"
    t.string "previewImageUrl"
    t.string "slug"
    t.jsonb "barcodes"
    t.string "barcode"
    t.string "unitType"
    t.string "soldBy"
    t.float "amountPerUnit"
    t.string "size"
    t.string "status"
    t.string "imageUrlBasename"
    t.string "currency"
    t.datetime "promotionStartsAt"
    t.datetime "promotionEndsAt"
    t.float "maxQuantity"
    t.boolean "customerNotesEnabled"
    t.float "price"
    t.float "normalPrice"
    t.string "nutritionalInfo"
    t.string "productBrand"
    t.string "productInfo"
    t.string "packingSize"
    t.string "descriptionHtml"
    t.string "countryOfOrigin"
    t.jsonb "tags"
    t.boolean "alcohol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amountPerUnit"], name: "index_products_on_amountPerUnit"
    t.index ["normalPrice"], name: "index_products_on_normalPrice"
    t.index ["packingSize"], name: "index_products_on_packingSize"
    t.index ["price"], name: "index_products_on_price"
    t.index ["title"], name: "index_products_on_title"
    t.index ["vendor"], name: "index_products_on_vendor"
    t.index ["vendor_product_id"], name: "index_products_on_vendor_product_id"
  end

end
