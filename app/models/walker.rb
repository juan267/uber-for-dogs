class Walker < ActiveRecord::Base
  has_many :walks
  has_many :dogs, through: :walks
  validates :email, uniqueness: true
  validates_email_format_of :email, :message => 'Invalid email'

  def total_distance
    total_distance = 0
    self.walks.each do |walk|
      total_distance += walk.distance
    end
    total_distance
  end

  def password=(plaintext)
    self.password_hash = BCrypt::Password.create(plaintext)
  end

  def authenticate(plaintext)
    if BCrypt::Password.new(self.password_hash) == plaintext
      return true
    else
      return false
    end
  end
end
