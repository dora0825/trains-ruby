class Route
 
  attr_reader :destination

  def initialize(origin = nil, destination = nil, distance = 0)
    @origin = origin
    @destination = destination
    @distance = distance
    @connection = EndOfRoute.new
  end
  
  def stops
    1 + @connection.stops
  end

  def distance
    @distance + @connection.distance
  end

  def destination_s
    @connection.destination.empty? ? @destination.to_s : ''
  end

  def connection_s
    @origin.to_s + destination_s + @connection.connection_s
  end

  def to_s
    connection_s + distance.to_s
  end

  def connect(route)
    @connection = route
    self
  end

  def connect_to(city_names)
    connection = destination.route(city_names)
    return connection if connection == NO_ROUTE
    connect connection
  end

end

class City
  attr_reader :name

  def route(city_names) 
    return EndOfRoute.new if city_names == nil || city_names.empty?
    destination = @destinations[city_names[0]]
    return NO_ROUTE if destination == nil
    connecting_city_names = city_names.slice 1,city_names.length
    build_route_to(destination).connect_to(connecting_city_names)
  end

  def all_routes_to(final_destination, max_stops=20, stops=0)
    routes = []
    return routes if stops == max_stops
    routes.concat(build_direct_route_to final_destination)
    routes.concat(build_connection_routes_to final_destination, max_stops, stops)
  end

  def build_connection_routes_to(final_destination, max_stops, stops)
    connecting_routes = []
    @destinations.each_value do |destination|
      destination.city.all_routes_to(final_destination, max_stops, stops + 1).each do |connection|
        route = build_route_to destination
        connecting_routes << route.connect(connection)
      end
    end
    connecting_routes
  end

  def build_direct_route_to(final_destination)
    direct_route = route(final_destination.name)
    return [] if direct_route == NO_ROUTE
    [direct_route]
  end

  def build_route_to(destination)
    route = Route.new self, destination.city, destination.distance
    route
  end

  def initialize(name)
    @name = name
    @destinations = {}
  end

  def add_destination(destination)
    @destinations[destination.city.name] = destination
  end

  def empty?
    @name.empty?
  end

  def to_s
    @name
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

  def find_by_exact_stops(*args)
    return NO_ROUTE if args.length < 2
    origin = find_city(args[0])
    origin.route(args.slice(1,args.length))
  end

  def find_by_number_of_stops(origin, destination, number_of_stops=1)
    handle_missing(origin, destination) do 
      find_by_max_stops(origin, destination, number_of_stops).select do |route|
        route.stops == number_of_stops
      end
    end
  end

  def find_by_max_stops(origin, destination, max_stops=20)
    handle_missing(origin, destination) do 
      origin_city = find_city origin
      destination_city = find_city destination
      origin_city.all_routes_to destination_city, max_stops
    end
  end

  def find_by_shortest_route(origin, destination)
    find_by_max_stops(origin, destination).min { |route_a, route_b| route_a.distance <=> route_b.distance }
  end

  def find_by_distance_less_than(origin, destination, max_distance)
    find_by_max_stops(origin, destination).select { |route| route.distance < max_distance }
  end

  def handle_missing(origin, destination) 
    return [NO_ROUTE] if origin == nil || destination == nil
    yield
  end

end

class NoRoute
  def distance
    0
  end
  
  def connect(route)
  end

  def stops
    0
  end

  def destination
    ''
  end

  def destination_s
    ''
  end

  def connection_s
    ''
  end

  def to_s
    'NO SUCH ROUTE'
  end
end

NO_ROUTE = NoRoute.new

class EndOfRoute < NoRoute
  def to_s
    ''
  end
end
