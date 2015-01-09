class Walk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walker
  has_many :coords

  def path
    path = []
    self.coords.each do |coord|
      path << [coord.latitude, coord.longitude]
    end
    path
  end

  def path=(input)
    path = input
  end

  def distance
    total_distance = 0
    coords = self.coords
    i = coords.length
    while i > 0
      total_distance += get_distance(coords[i-1], coords[i-2])
      i -= 1
    end
    (total_distance / 1000).round(2)
  end

  def rad (x)
    x * (Math::PI) /180
  end

  def get_distance(p1, p2)
    r = 6378137
    dLat = rad(p2.latitude - p1.latitude)
    dLong = rad(p2.longitude - p1.longitude)
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(rad(p1.latitude)) * Math.cos(rad(p2.latitude)) *
      Math.sin(dLong / 2) * Math.sin(dLong / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    d = r * c
    return d
  end



end
