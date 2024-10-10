class PlatformProductsController < ApplicationController
  def show

    @platform_product = PlatformProduct.find(params[:id])
    @candidates = @platform_product.candidates
  end

  def approved_products
    @platform_products = PlatformProduct.in_state(:approved).includes(:platform_product_prices)

  end
end
#  price_text = book.css('.sitePrice').text.strip
#  book_price = price_text.gsub('£', '').to_d
#  price_text = book.css('.price.current-price').text.strip
#  book_price = price_text.gsub('$', '').to_d