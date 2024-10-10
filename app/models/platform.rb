class Platform < ApplicationRecord
  has_many :platform_products, dependent: :destroy
end
