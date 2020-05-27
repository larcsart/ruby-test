class HomeController < ApplicationController
  def index
    @offers = offers_service.find_all
  end

  private

  def offers_service
    @offers_service ||= ::OffersService.new(offers_repository)
  end

  def offers_repository
    @offers_repository ||= ::SqliteRepository.new
  end
end
