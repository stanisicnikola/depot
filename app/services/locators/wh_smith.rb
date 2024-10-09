module Services
  module Locators
    class WHSmith
      attr_accessor :platform_product_id, :platform_product
  
      def initialize(platform_product_id)
        @platform_product_id = platform_product_id
        @platform_product = PlatformProduct.find(platform_product_id)
      end
  
      def perform
        platform_product.transition_to(:locating)

        begin
          platform_code = platform_product.platform.code
          url = Platform::URLS[platform_code.to_sym]

          request_url = "#{url}#{CGI.escape(platform_product.product.title)}"

          full_request_url = request_url + "&productType=1"

          response = HTTParty.get(full_request_url)
          document = Nokogiri::HTML(response.body)

    
          all_books = document.css('.search-item--inStock').first(10)
          all_books.each do |book|
            book_title_element = book.css('h3.search-item__title a')
            sub_title_element = book.css('h3.search-item__title span.product__title--subTitle')

          
            book_title = book_title_element.text.strip
            sub_title = sub_title_element ? sub_title_element.text.strip : ""
            full_title = "#{book_title} #{sub_title}".strip
    
            book_url = book.css('a.jacket-Book').attr('href').value
            full_book_url = "https://www.whsmith.co.uk" + book_url
    
            book_image_url = book.css('img.img-fluid').attr('data-src').value
            full_book_image_url = "https:" + book_image_url
    

            #book_price = book.css('.format + span')
            #puts "Cijena knjige: #{book_price.text}"
    
            Candidate.create!(
              title: full_title,
              url: full_book_url,
              image_url: full_book_image_url,
              platform_product_id: platform_product_id
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