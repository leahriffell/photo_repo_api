require 'rails_helper'

RSpec.describe PhotoTrip, type: :model do
  describe 'relationships' do
    it { should belong_to :photo }
    it { should belong_to :trip }
  end
end
