require 'debugger'

class Game




end

class Grid
  attr_accessor :rows, :user_grid, :mines, :revealed

  def initialize
    @rows = place_mines(create_grid)
    # debugger
    @mines = get_mine_coordinates
    mark_neighboring_mines
    @user_grid = print_grid_dev
    @revealed = []
    game_loop
  end

  def tile_array
    array = []
    @rows.each do |row|
      row.each do |tile|
        array << each
      end
    end
    array
  end

  def game_loop
    until game_end?
      print_grid
      p get_mine_coordinates
      get_command
    end
    puts "you lose"
  end

  def get_command
    print "Choose f/r followed by your choice of x and y coordinates"
    response = gets.chomp
    command = response.split(" ")[0]
    x = response.split(" ")[1].to_i
    y = response.split(" ")[2].to_i
    case command
    when "f"
      # flag_tile(x,y)
    when "r"
      reveal_tile(x,y)
    else
      puts "Invalid entry. Please try again."
      get_command
    end
  end

  def reveal_tile(x,y)
    @revealed << [x,y]
  end

  def reveal_neighbors(x,y)
    @rows.each do |row|
      row.each do |tile|
        if tile.coordinates == [x,y]
          tile.neighbor_coordinates
        end
      end
    end
  end

  def game_end?
    (@revealed & @mines).length >= 1
  end

  def create_grid(grid_size = 9)
    grid = Array.new(grid_size) {[nil] * grid_size}
    grid.each_with_index do |row, y|
      row.each_with_index do |grid_unit, x|
        row[x] = Tile.new(x, y)
      end
    end
  end

  def get_mine_coordinates
    mines = []
    @rows.each do |row|
      row.each do |tile|
        if tile.mine == true
          mines << tile.coordinates
        end
      end
    end
    mines
  end

  def mark_neighboring_mines
    @rows.each do |row|
      row.each do |tile|

        tile.neighboring_mines = (tile.neighbor_coordinates & @mines).length
      end
    end

  end

  def place_mines(grid, amount = 10)
    amount.times do
      grid.sample.sample.mine = true
    end
    grid
  end

  def print_grid_dev(grid_size = 9)
    formatted_array = []
    @rows.each_with_index do |row, y|
      formatted_array << []
      row.each_with_index do |tile, x|
        if tile.mine == true
          formatted_array[y][x] = "*"
        elsif tile.neighboring_mines != nil
          formatted_array[y][x] = tile.neighboring_mines
        else
          formatted_array[y][x] = tile.neighboring_mines.to_i
        end
      end

    end
    puts "      T H E  B O A R D      "
    puts "----------------------------"
    formatted_array.each_with_index do |row, index|
      puts "#{index}| #{row.join("  ")}"
    end
      puts "----------------------------"
      puts "   0  1  2  3  4  5  6  7  8"
    nil
  end

  def print_grid(grid_size = 9)
    formatted_array = []
    @rows.each_with_index do |row, y|
      formatted_array << []
      row.each_with_index do |tile, x|
        if @revealed.include?(tile.coordinates)
          if tile.mine == true
            formatted_array[y][x] = "*"
          elsif tile.neighboring_mines != nil
            formatted_array[y][x] = tile.neighboring_mines
          else
            formatted_array[y][x] = tile.neighboring_mines.to_i
          end
        else
          formatted_array[y][x] = "X"
        end
      end

    end
    puts "      T H E  B O A R D      "
    puts "----------------------------"
    formatted_array.each_with_index do |row, index|
      puts "#{index}| #{row.join("  ")}"
    end
      puts "----------------------------"
      puts "   0  1  2  3  4  5  6  7  8"
    nil
  end

end

class Tile

  attr_accessor :coordinates, :flag, :mine, :neighboring_mines, :neighbor_coordinates, :revealed

  def initialize(x, y)
    @coordinates = [x,y]
    @x = x
    @y = y
    @neighbor_coordinates = neighbor_coordinates
  end


  def neighbor_coordinates
    # this should return an array of valid neighbor coordinates
    directions = {
      :north => [@x, @y - 1],
      :south => [@x, @y + 1],
      :east => [@x + 1, @y],
      :west => [@x - 1, @y],
      :northeast => [@x + 1 , @y - 1],
      :northwest => [@x - 1 , @y - 1],
      :southeast => [@x + 1 , @y + 1],
      :southwest => [@x - 1 , @y + 1]
    }

    neighbor_coordinates_array = []
    directions.each do |direction, coordinates|
      next unless coordinates.all? {|i| i >= 0 && i <= 8 }
      neighbor_coordinates_array << coordinates
    end
    neighbor_coordinates_array
  end


end

game = Grid.new





