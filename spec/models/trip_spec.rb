require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :photo_trips }
    it { should have_many(:photos).through(:photo_trips) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
  end
end
