class Grid
	attr_accessor :board, :living_spaces, :dead_spaces
	def initialize(board)
		@board = board
		@living_spaces = Array.new
		@dead_spaces = Array.new
	end

	def dead_or_alive?(array)
		row = array[0]
		position = array[1]
		board[row][position] != 1 ? (return "dead") : (return "alive")
	end

	def store_living_and_dead_spaces
		row = 0
		position = 0
		until row == (get_total_rows)
			until position == (get_total_rows)
				living_spaces << [row, position] if dead_or_alive?([row,position]) == "alive"
				dead_spaces << [row, position] if dead_or_alive?([row,position]) == "dead"
				position += 1
			end 
			position = 0
		  row += 1
		end
	end

	def get_all_coordinates
		coordinates = living_spaces + dead_spaces
		coordinates.sort	
	end

	def identify_neighbors(origin)
		neighbors = Array.new
		row = origin[0]
		position = origin[1]
		max_row = get_total_rows - 1
		if row != 0 and row != max_row and position != 0 and position != max_row
			neighbors << [row, position-1] << [row, position + 1] << [row-1, position-1] << [row-1, position] << [row-1, position+1] << [row+1, position-1] << [row + 1, position] << [row+1, position+1]
			return neighbors.sort
		elsif row == 0 and position == 0
			neighbors << [row, position+1] << [row+1, position] << [row+1, position+1]
		elsif row == 0 and position != max_row and position != 0
			neighbors << [row, position-1] << [row, position +1] << [row+1, position-1] << [row+1, position] << [row+1, position+1]
		elsif row == 0 and position == max_row
			neighbors << [row, position-1] << [row+1, position-1] << [row+1, position]
		elsif row != 0 and row != max_row and position == 0
			neighbors << [row-1, position] << [row-1, position+1] << [row, position+1] << [row+1, position] << [row+1, position+1]
		elsif row == max_row and position == 0 
			neighbors << [row-1, position] << [row-1, position+1] << [row, position+1]
		elsif row == max_row and position != max_row and position != 0
			neighbors << [row, position-1] <<[row-1, position-1] << [row-1, position] << [row-1, position+1] << [row, position+1]
		elsif row == max_row and position == max_row
			neighbors << [row, position-1] << [row-1, position-1] << [row, position]
		elsif row != 0 and row != max_row and position == max_row
			neighbors << [row-1, position-1] << [row-1, position] << [row+1, position-1] << [row+1, position]
		end
		return neighbors
 	end

	def get_total_rows
		row_count = 0
		board.each do |row|
			row_count += 1
		end
		row_count
	end

	def print_grid
		board.each do |row|
			print_row_contents(row)
			puts "\n"
		end
	end

	def print_row_contents(row)
		row.each do |number|
			print number
		end
	end

end