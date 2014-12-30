class Walker < ActiveRecord::Base
  has_many :walks
  has_many :dogs, through: :walks
end
