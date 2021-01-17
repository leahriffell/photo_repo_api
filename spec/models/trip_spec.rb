require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :photo_trips }
    it { should have_many(:photos).through(:photo_trips) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :destination }
  end

  describe 'class methods' do
    describe 'top_trips(limit)' do
      it 'returns most popular trip destinations' do
        10.times { create(:trip, destination: 'Paris') }
        7.times { create(:trip, destination: 'Spain') }
        5.times { create(:trip, destination: 'Da Nang, Vietnam') }

        top_three = Trip.top_trips(3)
        expect(top_three.length).to eq(3)
        expect(top_three[0][:destination]).to eq('Paris')
        expect(top_three[1][:destination]).to eq('Spain')
        expect(top_three[2][:destination]).to eq('Da Nang, Vietnam')

        top_one = Trip.top_trips(1)
        expect(top_one.length).to eq(1)
        expect(top_one[0][:destination]).to eq('Paris')
      end
    end
  end
end
