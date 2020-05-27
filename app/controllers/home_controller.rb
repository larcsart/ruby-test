class HomeController < ApplicationController
  def index
    @offers = filter_enabled(offers_service.find_all)
  end

  private

  def offers_service
    @offers_service ||= ::OffersService.new(offers_repository)
  end

  def offers_repository
    @offers_repository ||= ::SqliteRepository.new
  end

  def filter_enabled(offers)
    offers.select do |offer|
      offer.status == ::OfferStatus::ENABLED
    end
  end
end
