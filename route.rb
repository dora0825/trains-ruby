class Route
  
  def initialize(origin = nil, destination = nil, distance = 0)
    @origin = origin
    @destination = destination
    @distance = distance
    @connection = EndOfRoute.new
  end

  def connect(route)
    @connection = route
  end

  def distance
    @distance + @connection.distance
  end

  def destination_s
    @connection.destination_s.empty? ? @destination : '' 
  end

  def connection_s
    @origin + destination_s + @connection.connection_s
  end

  def to_s
    connection_s + distance.to_s
  end

end

class EndOfRoute
  def distance
    0
  end

  def origin_s
    ''
  end
  
  def destination_s
    ''
  end

  def connection_s
    ''
  end

  def to_s
    ''
  end
end
