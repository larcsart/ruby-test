class OffersService
  attr_reader :repository
  
  def initialize(repository)
    @repository = repository
  end

  def create(offer_params)
    repository.create(offer_params)
  end

  def find_all
    repository.find_all
  end

  def destroy(offer_id)
    repository.destroy(offer_id)
  end

  def enable(offer_id)
    repository.update_status(offer_id, OfferStatus::ENABLED)
  end

  def disable(offer_id)
    repository.update_status(offer_id, OfferStatus::DISABLED)
  end
end
