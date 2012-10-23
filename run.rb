require './route.rb'

routes = Routes.new 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'

# 1. The distance of the route A-B-C.
puts routes.find('A','B','C').distance

# 2. The distance of the route A-D.
puts routes.find('A','D').distance

# 3. The distance of th,e route A-D-C.
puts routes.find('A','D','C').distance

# 4. The distance of the route A-E-B-C-D.
puts routes.find('A','E','B','C','D').distance

# 5. The distance of the route A-E-D.
puts routes.find('A','E','D')

# 6. The number of trips starting at C and ending at C with a maximum of 3 stops.  In the sample data below, there are two such trips: C-D-C (2 stops). and C-E-B-C (3 stops).
puts routes.find_by_max_stops('C', 'C', 3).length

# 7. The number of trips starting at A and ending at C with exactly 4 stops.  In the sample data below, there are three such trips: A to C (via B,C,D); A to C (via D,C,D); and A to C (via D,E,B).
# 8. The length of the shortest route (in terms of distance to travel) from A to C.
# 9. The length of the shortest route (in terms of distance to travel) from B to B.
# 10. The number of different routes from C to C with a distance of less than 30.  In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC, CEBCEBC, CEBCEBCEBC.
