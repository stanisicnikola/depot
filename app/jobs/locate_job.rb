require 'httparty'
require 'nokogiri'
require 'cgi'
require_relative '../services/locators/barnes_and_noble'
require_relative '../services/locators/wh_smith'

class LocateJob < ApplicationJob
  queue_as :default

  def perform(platform_product_id)

    platform_product = PlatformProduct.find(platform_product_id)
    platform_code = platform_product.platform.code

    if platform_code == 'barnes_and_noble'
      ::Services::Locators::BarnesAndNoble.new(platform_product_id).perform
    else
      ::Services::Locators::WHSmith.new(platform_product_id).perform
    end
  end
end
