require 'rails_helper'

RSpec.describe OffersService do
  subject { OffersService.new(repository) }

  let(:repository) { MemoryRepository.new }

  let(:params) do
    {
      title: 'Anuncio 1',
      url: 'http://www.google.com',
      description: 'Primeiro anúncio',
      starts_at: Date.new(2020, 1, 1),
      ends_at: Date.new(2020, 1, 7),
      premium: false
    }
  end

  describe '#create' do
    context 'valid params' do
      it 'delegates to repository' do
        expect(repository).to receive(:create).with(params)

        subject.create(params)
      end
    end
  end

  describe '#find_all' do
    before(:each) do
      repository.create(params)
    end

    context 'valid params' do
      it 'delegates to repository' do
        expect(repository).to receive(:find_all)

        subject.find_all
      end

      it 'returns all offers' do
        offers = subject.find_all

        expect(offers.size).to eq(1)

        offer = offers.first

        expect(offer.title).to eq(params[:title])
        expect(offer.url).to eq(params[:url])
        expect(offer.description).to eq(params[:description])
        expect(offer.starts_at).to eq(params[:starts_at])
        expect(offer.ends_at).to eq(params[:ends_at])
        expect(offer.premium).to eq(params[:premium])
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      repository.create(params)
    end

    context 'valid id' do
      let(:offer_id) { 1 }

      it 'delegates to repository' do
        expect(repository).to receive(:destroy).with(offer_id)

        subject.destroy(offer_id)
      end

      it 'does not raise error' do
        expect do
          subject.destroy(offer_id)
        end.to_not raise_error
      end
    end

    context 'invalid id' do
      let(:offer_id) { 9999 }

      it 'delegates to repository' do
        expect(repository).to receive(:destroy).with(offer_id)

        subject.destroy(offer_id)
      end

      it 'does not raise error' do
        expect do
          subject.destroy(offer_id)
        end.to_not raise_error
      end
    end
  end

  describe '#enable' do
    before(:each) do
      repository.create(params)
    end

    context 'valid id' do
      let(:offer_id) { 1 }

      it 'delegates to repository' do
        expect(repository).to receive(:update_status).with(offer_id, OfferStatus::ENABLED)

        subject.enable(offer_id)
      end

      it 'does not raise error' do
        expect do
          subject.enable(offer_id)
        end.to_not raise_error
      end
    end

    context 'invalid id' do
      let(:offer_id) { 9999 }

      it 'delegates to repository' do
        expect(repository).to receive(:update_status).with(offer_id, OfferStatus::ENABLED)

        subject.enable(offer_id)
      end

      it 'does not raise error' do
        expect do
          subject.enable(offer_id)
        end.to_not raise_error
      end
    end
  end

  describe '#disable' do
    before(:each) do
      repository.create(params)
    end

    context 'valid id' do
      let(:offer_id) { 1 }

      it 'delegates to repository' do
        expect(repository).to receive(:update_status).with(offer_id, OfferStatus::DISABLED)

        subject.disable(offer_id)
      end

      it 'does not raise error' do
        expect do
          subject.disable(offer_id)
        end.to_not raise_error
      end
    end

    context 'invalid id' do
      let(:offer_id) { 9999 }

      it 'delegates to repository' do
        expect(repository).to receive(:update_status).with(offer_id, OfferStatus::DISABLED)

        subject.disable(offer_id)
      end

      it 'does not raise error' do
        expect do
          subject.disable(offer_id)
        end.to_not raise_error
      end
    end
  end
end
