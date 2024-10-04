class PlatformProductsController < ApplicationController
  def show
    @platform_product = PlatformProduct.find(params[:id])
    @candidates = @platform_product.candidates
  end
end
