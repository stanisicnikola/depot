class Platform < ApplicationRecord
  URLS = {
    wh_smith: 'https://www.whsmith.co.uk/Search/Keyword?keyword=',
    barnes_and_noble: 'https://www.barnesandnoble.com/s/'
  }

  has_many :platform_products, dependent: :destroy
end
