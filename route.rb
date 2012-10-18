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

class Routes

  def initialize(*args)
    @no_route = NoRoute.new
  end

  def find(*args)
    @no_route
  end

end

class NoRoute
  def to_s
    'NO SUCH ROUTE'
  end
end

class EndOfRoute
  def distance
    0
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
