module Services
  module Locators
    class BarnesAndNoble
      attr_accessor :platform_product_id, :platform_product
  
      def initialize(platform_product_id)
        @platform_product_id = platform_product_id
        @platform_product = PlatformProduct.find(platform_product_id)
      end
  
      def perform
        platform_product.transition_to(:locating)

        begin
          url = platform_product.platform.url
          request_url = "#{url}#{CGI.escape(platform_product.product.title)}"
          full_request_url = request_url + "/_/N-8q8"
          response = HTTParty.get(full_request_url)
          
          document = Nokogiri::HTML(response.body)
    
          all_books = document.css('.columns-4').first(10)
          all_books.each do |book|
            book_title = book.css('a').attr('title')
    
            book_url = book.css('a.pImageLink').attr('href').value
            full_book_url = "https://www.barnesandnoble.com" + book_url
    
            book_image_url = book.css('img.full-shadow').attr('src').value
            full_book_image_url = "https:" + book_image_url
    
            price_text = book.css('.format + span').text.strip
            book_price = price_text.gsub('$', '').to_d
    
            Candidate.create!(
              title: book_title,
              url: full_book_url,
              image_url: full_book_image_url,
              platform_product_id: platform_product_id,
              amount: book_price
            )
          end
          platform_product.transition_to(:located)
        rescue 
          platform_product.transition_to(:error)
        end
      end
    end
  end
end
