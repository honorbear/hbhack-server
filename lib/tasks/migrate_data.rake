namespace :db do
  desc 'Migrate all data from every source'
  task migrate_data: [
    :migrate_honestbee_data,
    :migrate_carrefour_data
  ]

  desc 'Migrate honest bee data'
  task migrate_honestbee_data: :environment do
    # Real API request
    # fetch_and_create_products(1)

    # Use prefetched data
    file = File.read('db/fixtures/products/honestbee.json')
    products = JSON.parse(file)['products']
    products.each do |product_attributes|
      vendor_product_id = product_attributes['id']
      product_attributes.except!('id')
      Product.create(product_attributes.merge(vendor_product_id: vendor_product_id, vendor: 'honestbee'))
    end
  end

  def fetch_and_create_products(page)
    fresh_by_honest_bee_tw_department_id = 22494

    response = HonestBee::API::Products.retrieve(fresh_by_honest_bee_tw_department_id, page: page)
    response['products'].each do |product_attributes|
      vendor_product_id = product_attributes.except!('id')
      Product.create(product_attributes.merge(vendor_product_id: vendor_product_id, vendor: 'honestbee'))
    end

    if response['meta']['current_page'] < response['meta']['total_pages']
      page = page + 1
      fetch_and_create_products(page)
    end
  end

  desc 'Migrate carrefour_data'
  task migrate_carrefour_data: :environment do
    file = File.read('db/fixtures/products/carrefour.json')
    products = JSON.parse(file)
    products.each do |product|
      Product.create(
        vendor: product['vendor'],
        title: product['name'],
        vendor_product_id: product['id'],
        amountPerUnit: product['quantity'],
        price: product['price'],
        currency: 'TWD',
        previewImageUrl: product['img']
      )
    end
  end
end
