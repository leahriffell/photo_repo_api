require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'relationships' do
    it { should have_many :photo_trips }
    it { should have_many(:trips).through(:photo_trips) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :url }
  end
end
