class PlatformProduct < ApplicationRecord
  belongs_to :product
  belongs_to :platform

  has_many :candidates, dependent: :destroy

end
