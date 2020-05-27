class SqliteRepository
  def create(offer_params)
    offer = Offer.new

    offer.title = offer_params[:title]
    offer.url = offer_params[:url]
    offer.description = offer_params[:description]
    offer.starts_at = offer_params[:starts_at]
    offer.ends_at = offer_params[:ends_at]
    offer.premium = offer_params[:premium]
    offer.status = OfferStatus::DISABLED

    offer.save
  end

  def find_all
    Offer.all
  end

  def update_status(offer_id, status)
    Offer.where(id: offer_id).update_all(status: status)
  end
end
