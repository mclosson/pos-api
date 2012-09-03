class ApiKey < ActiveRecord::Base

  attr_accessible :access_token, :expires_at, :location_id, :user_id
  before_create :generate_access_token
  validates :access_token, :uniqueness => true

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end
