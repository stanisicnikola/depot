class ContainersController < ApplicationController
  def index
    @products = Product.all
    @platforms = Platform.all
  end
end
