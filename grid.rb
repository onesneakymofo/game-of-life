
class Grid
  attr_accessor :cells, :started
  def initialize
    @cells = Hash.new
    @started = false
  end

  def reset
    @cells = Hash.new
  end

  def draw_horizontal_lines
    (Window.width / TILE_SIZE).times do |tile|
      Line.new(x1: tile * TILE_SIZE, x2: tile * TILE_SIZE, y1: 0, y2: Window.height, width: 1, color: LINE_COLOR)
    end
  end

  def draw_vertical_lines
    (Window.height / TILE_SIZE).times do |tile|
      Line.new(x1: 0, x2: Window.width, y1: tile * TILE_SIZE, y2: tile * TILE_SIZE, width: 1, color: LINE_COLOR)
    end
  end

  def toggle_cell(x, y)
    cell_x = x * TILE_SIZE
    cell_y = y * TILE_SIZE
    if cells.has_key?([x, y])
      cells.delete([x,y])
    else
      cells[[x , y]] = true
    end
  end

  def toggle_status
    @started = !started
  end

  def populate_cells
    cells.keys.each do |x, y|
      Square.new(x: x * TILE_SIZE, y: y * TILE_SIZE, size: TILE_SIZE, color: SQUARE_COLOR)
    end
  end

  def move_cells
    if started
      new_cells = Hash.new

      (Window.viewport_width / TILE_SIZE ).times do |x|
       (Window.viewport_height / TILE_SIZE).times do |y|
         cell_is_alive = cells.has_key?([x, y])
         cells_friends_count = [
           cells.has_key?([x-1, y-1]),
           cells.has_key?([x  , y-1]),
           cells.has_key?([x+1, y-1]),
           cells.has_key?([x+1, y  ]),
           cells.has_key?([x+1, y+1]),
           cells.has_key?([x  , y+1]),
           cells.has_key?([x-1, y+1]),
           cells.has_key?([x-1, y  ]),
         ].count(true)

         if((cell_is_alive && cells_friends_count.between?(2,3)) || (!cell_is_alive && cells_friends_count == 3))
           new_cells[[x, y]] = true
         end
       end
      end
      @cells = new_cells
    end
  end
end