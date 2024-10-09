class PlatformProductsController < ApplicationController
  def show

    @platform_product = PlatformProduct.find(params[:id])
    @candidates = @platform_product.candidates
  end

  def approved_products
    
    @platform_products = PlatformProduct.all

  end
end
