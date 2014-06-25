require 'rails_helper'

RSpec.describe User, :type => :model do

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :mood }
  end

  describe 'associations' do
    it {should have_many :shouts}
  end

  describe '.by_mood' do
    before do
      create(:user, first_name: 'Landon', last_name: 'West', mood: 'Pissed')
      create(:user, first_name: 'Josh', last_name: 'Hamilton', mood: 'Happy')
      create(:user, first_name: 'Dave', last_name: 'Nelson', mood: 'Happy')
    end
    it 'returns name of user with pissed mood' do
      expect(User.by_mood('Pissed').count).to eq 1
    end
    it 'does not include josh' do
      expect(User.by_mood('Pissed').collect(&:first_name)).to_not include 'Josh'
    end
  end

end
