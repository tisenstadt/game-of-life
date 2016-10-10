require 'test/unit'
require './grid.rb'
require './game.rb'

class GridTest < Test::Unit::TestCase

	def setup 
		@array = [[0,0,0,0,0],[0,0,1,0,0],[0,1,1,1,0],[0,0,0,0,0],[0,0,0,0,0]]
		@grid = Grid.new(@array)
	end

	def test_to_get_total_rows
		assert_equal @grid.get_total_rows, 5
	end


	def test_to_print_grid
		assert_nothing_thrown do 
			@grid.print_grid
		end
	end


	def test_to_check_if_alive_or_dead
		assert_equal "alive", @grid.dead_or_alive?([2,2])
		assert_equal "dead", @grid.dead_or_alive?([0,0])
		assert_equal "dead", @grid.dead_or_alive?([4,3])
	end

	def test_to_verify_living_spaces
		@grid.store_living_and_dead_spaces
		assert_equal [[1,2],[2,1],[2,2],[2,3]], @grid.living_spaces
	end

	def test_to_verify_dead_spaces
		@grid.store_living_and_dead_spaces
		assert_equal [[0,0],[0,1],[0,2],[0,3],[0,4],[1,0],[1,1],[1,3],[1,4],[2,0],[2,4],[3,0],[3,1],[3,2],[3,3],[3,4],[4,0],[4,1],[4,2],[4,3],[4,4]], @grid.dead_spaces
	end

	def test_to_retrieve_coordinates
		@grid.store_living_and_dead_spaces
		assert_equal [[0,0],[0,1],[0,2],[0,3],[0,4],[1,0],[1,1],[1,2],[1,3],[1,4],[2,0],[2,1],[2,2],[2,3],[2,4],[3,0],[3,1],[3,2],[3,3],[3,4],[4,0],[4,1],[4,2],[4,3],[4,4]], @grid.get_all_coordinates
	end

	def test_to_identify_neighbors
		assert_equal [[1,1],[1,2],[1,3],[2,1],[2,3],[3,1],[3,2],[3,3]], @grid.identify_neighbors([2,2])
		assert_equal [[3,0],[3,1],[4,1]], @grid.identify_neighbors([4,0])
		assert_equal [[0,0],[0,1],[1,1],[2,0],[2,1]], @grid.identify_neighbors([1,0])
	end
end

class GameTest < Test::Unit::TestCase
	def setup
		@array = [[0,0,0,0,0],[0,0,1,0,0],[0,1,1,1,0],[0,0,0,0,0],[0,0,0,0,0]]
		@game = Game.new(Grid.new(@array))
	end

	def test_to_count_neighbors
		assert_equal 3, @game.count_neighbors([0,0])
		assert_equal 8, @game.count_neighbors([2,2])
		assert_equal 8, @game.count_neighbors([1,1])
		assert_equal 8, @game.count_neighbors([1,2])
	end

	def test_to_count_living_and_dead_neighbors
		living = @game.count_living_and_dead_neighbors([1,1])[:living]
		dead = @game.count_living_and_dead_neighbors([1,1])[:dead]
		assert_equal 3, living
		assert_equal 5, dead
	end

	def test_to_verify_switches
		@game.identify_switch([1,1])
		@game.identify_switch([2,2])
		assert @game.switches_to_make.include?([1,1])
		assert !@game.switches_to_make.include?([2,2])
	end

	def test_to_evalaute_all_coordinates_for_switches
		@game.evaluate_all_coordinates_for_switches
		assert @game.switches_to_make.include?([1,1])
		assert !@game.switches_to_make.include?([2,2])
	end

	def test_to_verify_switches_on_board
		@game.evaluate_all_coordinates_for_switches
		@game.perform_switches
		assert_equal 1, @game.grid.board[1][1]
	end

end
