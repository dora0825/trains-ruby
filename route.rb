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

class City
  attr_reader :name
  def initialize(name)
    @name = name
    @destinations = {}
    @no_route = NoRoute.new
  end

  def add_destination(destination)
    @destinations[destination.city.name] = destination
  end

  def route(city_name) 
    destination = @destinations[city_name]
    return @no_route if destination == nil
    Route.new @name, destination.city.name, destination.distance
  end
end

class Destination
  attr_reader :city, :distance
  def initialize(city, distance)
    @city = city
    @distance = distance
  end
end

class Routes

  def initialize(route_data)
    @cities = {}
    route_data.scan(/[a-zA-Z]{2}\d/) do |route|
      origin = route[0]
      destination = route[1]
      distance = route[2].to_i
      find_city(origin).add_destination(Destination.new(find_city(destination),distance))
    end
  end

  def find_city(name)
    @cities[name] = City.new(name) if !@cities.has_key?(name)
    @cities[name]
  end

  def find(*args)
    origin = find_city(args[0])
    origin.route(args[1])
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
