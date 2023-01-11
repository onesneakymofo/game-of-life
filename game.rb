# frozen_string_literal: true

# Game of Life
# Click on a square to create a square
# Press p to play
# Press p to clear
# Press escape to exit

require 'ruby2d'
require_relative 'grid'

TILE_SIZE = 25
GRID_SIZE = 10
LINE_COLOR = 'lime'
BACKGROUND_COLOR = 'black'
SQUARE_COLOR = 'lime'

set title: 'Game of Life',
    background: 'black',
    resizable: false,
    borderless: false,
    viewport_width: TILE_SIZE * GRID_SIZE,
    viewport_height: TILE_SIZE * GRID_SIZE,
    height: Window.height + TILE_SIZE

grid = Grid.new

on :mouse_down do |event|
  x = (event.x / TILE_SIZE)
  y = (event.y / TILE_SIZE)
  grid.toggle_cell(x, y)
end

on :key_down do |event|
  grid.toggle_status if event.key == 'p'
  if event.key == 'c'
    grid.started = false
    grid.reset
  end
  exit if event.key == 'escape'
end

update do
  clear
  grid.draw_vertical_lines
  grid.draw_horizontal_lines
  grid.populate_cells
  grid.move_cells if (Window.frames % 10).zero?
end

show
