class CandidatesController < ApplicationController
  def index
    platform_product_id = params[:platform_product_id]
    @candidates = Candidate.where(platform_product_id: platform_product_id)
    respond_to do |format|
      format.json { render json: @candidates }
    end
  end

  def approve

    candidate = Candidate.find(params[:id])
    platform_product= candidate.platform_product

    platform_product.title = candidate.title
    platform_product.image_url = candidate.image_url
    platform_product.url = candidate.url
    platform_product.transition_to(:approved)
    
    if platform_product.save
      render json: { success: true, platform_product: platform_product.reload, state: platform_product.reload.current_state }, status: :ok
    else
      render json: { success: false, errors: platform_product.errors }, status: :unprocessable_entity
    end

  end
end
