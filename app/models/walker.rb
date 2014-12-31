class Walker < ActiveRecord::Base
  has_many :walks
  has_many :dogs, through: :walks
  validates :email, uniqueness: true
  validates_email_format_of :email, :message => 'Invalid email'

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
