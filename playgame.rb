require './game.rb'

game = Game.new(Grid.new([[0,0,0,0,0],[0,0,1,0,0],[0,1,1,1,0],[0,0,0,0,0],[0,0,0,0,0]]))
puts "Welcome to the Game of Life! Your initial coordinates are: "
game.grid.print_grid
game.evaluate_all_coordinates_for_switches
puts "After playing a round of the game, your new coordinates are: "
game.perform_switches
game.grid.print_grid
