require 'rails_helper'

RSpec.describe SqliteRepository do
  subject { SqliteRepository.new }

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
      it 'persists offer' do
        expect do
          subject.create(params)
        end.to change { Offer.count }.by(1)
      end

      it 'persists with correct values' do
        subject.create(params)

        offer = Offer.first

        expect(offer.title).to eq(params[:title])
        expect(offer.url).to eq(params[:url])
        expect(offer.description).to eq(params[:description])
        expect(offer.starts_at).to eq(params[:starts_at])
        expect(offer.ends_at).to eq(params[:ends_at])
        expect(offer.premium).to eq(params[:premium])
      end
    end
  end

  describe '#find_all' do
    before(:each) do
      subject.create(params)
    end

    context 'valid params' do
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

      it 'does not change anything' do
        expect do
          subject.find_all
        end.to_not change { Offer.count }
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      subject.create(params)
    end

    context 'valid id' do
      let(:offer_id) { 1 }

      it 'deletes offer' do
        expect do
          subject.destroy(offer_id)
        end.to change { Offer.count }.by(-1)
      end
    end

    context 'invalid id' do
      let(:offer_id) { 9999 }

      it 'does not delete any offer' do
        expect do
          subject.destroy(offer_id)
        end.to change { Offer.count }.by(0)
      end

      it 'does not raise error' do
        expect do
          subject.destroy(offer_id)
        end.to_not raise_error
      end
    end
  end

  describe '#update_status' do
    before(:each) do
      subject.create(params)
    end

    context 'valid id' do
      let(:offer_id) { 1 }

      it 'updates offer' do
        expect do
          subject.update_status(offer_id, OfferStatus::ENABLED)
        end.to change { Offer.first.status }
      end

      it 'does not change the offers list' do
        expect do
          subject.update_status(offer_id, OfferStatus::ENABLED)
        end.to_not change { Offer.count }
      end

      it 'does not raise error' do
        expect do
          subject.update_status(offer_id, OfferStatus::ENABLED)
        end.to_not raise_error
      end
    end

    context 'invalid id' do
      let(:offer_id) { 9999 }

      it 'does not change existing offer' do
        expect do
          subject.update_status(offer_id, OfferStatus::ENABLED)
        end.to_not change { Offer.first.status }
      end

      it 'does not change the offers list' do
        expect do
          subject.update_status(offer_id, OfferStatus::ENABLED)
        end.to_not change { Offer.count }
      end

      it 'does not raise error' do
        expect do
          subject.update_status(offer_id, OfferStatus::ENABLED)
        end.to_not raise_error
      end
    end
  end
end
