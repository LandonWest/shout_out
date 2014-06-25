require 'rails_helper'

RSpec.describe Shout, :type => :model do

  describe 'validations' do
    it { should validate_presence_of :message }
  end

  describe 'associations' do
    it {should belong_to :user }
  end

  describe '.angrify' do
    it 'returns shout in all caps with 3 exclamation marks at the end' do
      expect(Shout.angrify('angry')).to eq 'ANGRY!!!'
    end
  end

  describe '.by_time', :focus do
    before do
      create(:shout, created_at: DateTime.new(2014,6,24))
      create(:shout, created_at: DateTime.new(2014,6,20))
      create(:shout, created_at: DateTime.new(2014,6,18))
      create(:shout, created_at: DateTime.new(2014,6,16))
    end
    it 'finds shouts posted before a certain time' do
      expect(Shout.by_time(DateTime.new(2014,6,19)).count).to eq 2
    end
  end

end
