class OffersService
  attr_reader :repository

  def initialize(repository)
    @repository = repository
  end

  def create(offer_params)
    repository.create(offer_params)
  end

  def find_all
    filter_expired(repository.find_all)
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

  private

  def filter_expired(offers)
    offers.select do |offer|
      offer.starts_at <= Time.now.utc && offer.ends_at >= Time.now.utc
    end
  end
end
