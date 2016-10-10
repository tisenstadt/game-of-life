require './grid.rb'

class Game
	attr_accessor :grid, :switches_to_make 
	def initialize(grid)
		@grid = grid
		@switches_to_make = Array.new
	end

	def evaluate_all_coordinates_for_switches
		grid.store_living_and_dead_spaces
		coordinates = grid.get_all_coordinates
		coordinates.each do |coordinate|
			identify_switch(coordinate)
		end
	end


	def identify_switch(space)
		status_of_neighbors = count_living_and_dead_neighbors(space)
		if status_of_neighbors[:living] < 2 and grid.dead_or_alive?(space) == "alive"
			add_switch(space)
		elsif status_of_neighbors[:living] > 3 and grid.dead_or_alive?(space) == "alive"
			add_switch(space)
		elsif status_of_neighbors[:living]  == 3 and grid.dead_or_alive?(space) == "dead"
			add_switch(space)
		end
	end

	def count_living_and_dead_neighbors(space)
		neighbors = grid.identify_neighbors(space)
		status_of_neighbors_hash = loop_through_neighbors(neighbors)
	end

	def loop_through_neighbors(neighbors)
		status_of_neighbor = Hash.new(0)
		neighbors.each do |neighbor|
			status_of_neighbor[:living] += 1 if grid.dead_or_alive?(neighbor) == "alive"
			status_of_neighbor[:dead] += 1 if grid.dead_or_alive?(neighbor) == "dead"
		end
		return status_of_neighbor
	end

	def add_switch(array)
		self.switches_to_make << array
	end

	def count_neighbors(array)
		count_neighbors = 0	
		neighbors = grid.identify_neighbors(array)
		count_neighbors += neighbors.size
	end

	def perform_switches
		switches_to_make.each do |switch|
			if grid.board[switch[0]][switch[1]] == 1
				grid.board[switch[0]][switch[1]] = 0 
			else	
				grid.board[switch[0]][switch[1]] = 1 
			end
		end
		self.switches_to_make = Array.new
	end
end




