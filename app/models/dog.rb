class Dog < ActiveRecord::Base
  belongs_to :owner
  has_many :walks
  has_many :walkers, through: :walks

  def total_distance
    total_distance = 0
    self.walks.each do |walk|
      total_distance += walk.distance
    end
    total_distance
  end

end
