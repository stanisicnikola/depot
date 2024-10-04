class Platform < ApplicationRecord
  URLS = {
    amazon: 'https://www.amazon.com/s?k=',
    barnes_and_noble: 'https://www.barnesandnoble.com/s/'
  }

  has_many :platform_products, dependent: :destroy
end

  #https://www.amazon.com/s?k=Dune&i=stripbooks-intl-ship&ref=nb_sb_noss
  #https://www.amazon.com/s?k=Dune&i=stripbooks-intl-ship&crid=3FQUI6Y93SYNC&sprefix=dune%2Cstripbooks-intl-ship%2C210&ref=nb_sb_noss_1