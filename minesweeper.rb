class Game





end

class Grid

  def initialize
    @grid = place_mines(create_grid)

  end

  def create_grid(grid_size = 9)
    grid = Array.new(grid_size) {[nil] * grid_size}
    grid.each_with_index do |row, y|
      row.each_with_index do |grid_unit, x|
        row[x] = GridUnit.new(x, y)
      end
    end
  end

  def place_mines(grid, amount = 10)
    amount.times do
      grid.sample.sample.mine = true
    end
    grid
  end

end

class GridUnit
  attr_accessor :coordinates, :flag, :mine, :neighboring_mines, :neighbors

  def initialize(x,y)
    @coordinates = [x,y]

  end

end
