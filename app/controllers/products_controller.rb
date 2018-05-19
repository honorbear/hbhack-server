class ProductsController < ApplicationController
  def report
    # params format
    # {
    #   vendor: string, vendor name
    #   id: integer, product id
    #   name: string, product name
    #   quantity: integer
    #   price: integer
    #   img: string, image link to product
    # }
    @products = params[:products]
    @response_products = @products.map do |product|
      query = "similarity(?, products.title) > ?"
      proposed_products = Product.where(query, product['name'], 0).where(vendor: 'honestbee').limit(2)
      puts proposed_products[0].title if proposed_products.size > 0
      product.merge(
        proposed_products: proposed_products.map do |proposed_product|
          {
            info: proposed_product_info(proposed_product),
            link: honestbee_link(proposed_product.vendor_product_id)
          }
        end
      )
    end

    render json: { products: @response_products }
  end

  private

  def proposed_product_info(proposed_product)
    %(#{proposed_product.title} #{proposed_product.packingSize} #{proposed_product.price})
  end

  def honestbee_link(product_id)
    "https://www.honestbee.tw/zh-TW/groceries/stores/fresh-by-honestbee-tw/products/#{product_id}"
  end
end
