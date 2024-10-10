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

    if platform_product.update(
      title: candidate.title,
      image_url: candidate.image_url,
      url: candidate.url
      )
      platform_product.transition_to(:approved)

      PlatformProductPrice.where(platform_product_id: platform_product.id, most_recent: true).update_all(most_recent: false)

      PlatformProductPrice.create!(
      platform_product_id: platform_product.id,
      amount: candidate.amount,
      most_recent: true)

      render json: { success: true, platform_product: platform_product.reload, state: platform_product.reload.current_state }, status: :ok
    else
      render json: { success: false, errors: platform_product.errors }, status: :unprocessable_entity
    end

  end
end

