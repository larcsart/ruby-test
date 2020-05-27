class MemoryRepository
  def initialize
    @offers = []
  end

  def create(offer_params)
    offer = Offer.new

    offer.title = offer_params[:title]
    offer.url = offer_params[:url]
    offer.description = offer_params[:description]
    offer.starts_at = offer_params[:starts_at]
    offer.ends_at = offer_params[:ends_at]
    offer.premium = offer_params[:premium]
    offer.status = OfferStatus::DISABLED

    @offers << offer
  end

  def find_all
    @offers
  end

  def update_status(offer_id, status)
    @offers.map! do |offer|
      return offer unless offer.id == offer_id

      offer.status = status
      offer
    end
  end

  def destroy(offer_id)
    @offers.delete_if { |offer| offer.id == offer_id }
  end
end
