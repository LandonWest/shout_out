class User < ActiveRecord::Base

  has_many :shouts
  validates :first_name, :last_name, :mood, presence: true

  def self.by_mood(mood)
    where(mood: mood)
  end

  def name
    [first_name, last_name].join(' ')
  end

end
