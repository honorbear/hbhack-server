namespace :db do
  desc "Migrate honest bee data"
  task migrate_honestbee_data: :environment do
    fetch_and_create_products(1)
  end

  def fetch_and_create_products(page)
    fresh_by_honest_bee_tw_department_id = 22494

    response = HonestBee::API::Products.retrieve(fresh_by_honest_bee_tw_department_id, page: page)
    response['products'].each do |product_attributes|
      hb_id = product_attributes.except!('id')
      Product.create(product_attributes.merge(hb_id: hb_id, vendor: 'honestbee'))
    end

    if response['meta']['current_page'] < response['meta']['total_pages']
      page = page + 1
      fetch_and_create_products(page)
    end
  end
end
