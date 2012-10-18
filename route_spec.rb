require './route.rb'

describe Route do
  
  describe '#route_to' do
    it 'should have a route for a connecting city' do
      route = Route.new 'a', 'b', 5
      route.distance.should eq(5)
    end
  end

end
