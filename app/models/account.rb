class Account < ActiveRecord::Base
  attr_accessible :name, :users_attributes
  has_many :locations, :dependent => :destroy
  has_many :users, :dependent => :destroy
  before_create :generate_registration_code
  validates :name, presence: true

  accepts_nested_attributes_for :users

  def generate_registration_code
    begin
      self.registration_code = SecureRandom.hex
    end while self.class.exists?(registration_code: registration_code)
  end

end
