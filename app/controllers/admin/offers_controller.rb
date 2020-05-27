module Admin
  class OffersController < ApplicationController
    def index
    end

    def create
      offer = offers_service.create(offer_params)

      redirect_to new_offer_path
    end

    def new
      @offers = offers_service.find_all
    end

    def edit
    end

    def show
    end

    def update
    end

    def destroy
      offers_service.destroy(params.require(:id))

      redirect_to new_offer_path
    end

    def enable
      offers_service.enable(params.require(:id))

      redirect_to new_offer_path
    end

    def disable
      offers_service.disable(params.require(:id))

      redirect_to new_offer_path
    end

    private

    def offers_service
      @offers_service ||= ::OffersService.new(offers_repository)
    end

    def offers_repository
      @offers_repository ||= ::SqliteRepository.new
    end

    def offer_params
      @offer_params ||= params.require(:offer).permit(:title, :url, :description, :starts_at, :ends_at, :premium)
    end
  end
end
