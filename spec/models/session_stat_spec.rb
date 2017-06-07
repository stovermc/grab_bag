require 'rails_helper'

RSpec.describe SessionStat do
  before do
    user = create(:regular_user)
    login(user)
  end
  context 'Attributes' do
    xit 'is invalid without log_in_time"' do

    end
  end
  
  context 'methods' do
    it 'can track log-on time' do
      expect(Session.last.log_in_time).to eq(Time.now)
    end
    
    it 'can track duration of a session' do
      sleep(3)
      logout
      expect(Session.last.duration).to eq(Time.now - (Time.now + 0.05))
    end
  end
end