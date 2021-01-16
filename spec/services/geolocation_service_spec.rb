require 'rails_helper'

RSpec.describe GeolocationService do
  describe 'happy paths' do
    it 'can fetch the lat and long for a destination' do
      VCR.use_cassette('geocode_denver') do
        response = GeolocationService.forward_geocode('Denver, CO')
        expect(response).to have_key(:lat)
        expect(response[:lat]).to be_a(Numeric)
        expect(response).to have_key(:lng)
        expect(response[:lng]).to be_a(Numeric)
      end

      VCR.use_cassette('geocode_caye_caulker') do
        response = GeolocationService.forward_geocode('Caye Caulker, Belize')
        expect(response).to have_key(:lat)
        expect(response[:lat]).to be_a(Numeric)
        expect(response).to have_key(:lng)
        expect(response[:lng]).to be_a(Numeric)
      end
    end
  end

  describe 'sad paths' do
    it 'no has no matching coordinates' do
      VCR.use_cassette('geocode_no_match') do
        response = GeolocationService.forward_geocode('abcdefghijklmnop')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:lat)
        expect(response).to have_key(:lng)
        expect(response[:lat]).to eq('no match')
        expect(response[:lng]).to eq('no match')
      end
    end
  end
end