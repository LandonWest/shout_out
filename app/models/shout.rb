class Shout < ActiveRecord::Base

  belongs_to :user
  validates :message, presence: true

  def self.angrify(message)
    message.upcase + '!!!'
  end

  def self.by_time(time)
    where(["created_at < ?", time])
  end

end
