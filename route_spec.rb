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
  end

end
