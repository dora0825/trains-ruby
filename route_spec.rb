require './route.rb'

describe Route do
  
  context 'with no connections' do

    let(:route) { Route.new 'a', 'b', 5 }

    it 'returns only its distance' do
      route.distance.should eq(5)
    end

    it 'can be represented as a string' do
      route.to_s.should eq('ab5')
    end

    it 'will have 1 stop' do
      route.stops.should eq(1)
    end

  end
  
  context 'with connections' do

    let(:route_a) { Route.new 'a', 'b', 5 }
    let(:route_b) { Route.new 'b', 'c', 4 }

    it 'calculates combined distance of routes' do
      route_a.connect route_b
      route_a.distance.should eq(9) 
    end

    it 'can be represented as a string' do
      route_a.connect route_b
      route_a.to_s.should eq('abc9') 
    end

    it 'will have 2 stop' do
      route_a.connect route_b
      route_a.stops.should eq(2)
    end

  end

end


describe Routes do

  context 'when desired route does not exists' do
    it 'should find NO SUCH ROUTE with single connection' do
      routes = Routes.new '' 
      routes.find('a', 'b').to_s.should eq('NO SUCH ROUTE')
    end

    it 'should find NO SUCH ROUTE with two connections' do
      routes = Routes.new 'ab5 bc4'
      routes.find('a', 'b', 'd').to_s.should eq('NO SUCH ROUTE')
    end
  end

  context 'when desired route exists' do
    it 'find a route with no connections' do
      routes = Routes.new 'ab5'
      routes.find('a','b').to_s.should eq('ab5')
    end

    it 'find a route with two connections' do
      routes = Routes.new 'ab5 bc4'
      routes.find('a','b','c').to_s.should eq('abc9')
    end

    it 'find a route with 5 connections' do
      routes = Routes.new 'ab5 bc4 ce3 ed7 da2'
      routes.find('a','b','c','e','d','a').to_s.should eq('abceda21')
    end
  end

end
