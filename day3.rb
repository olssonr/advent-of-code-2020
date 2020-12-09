# frozen_string_literal: true

# Class for storing and checking positions on the map
class Map
  attr_reader :map, :column_length, :row_length

  def initialize(rows:)
    @rows = rows
    @row_length = @rows[0].length
    @column_length = @rows.length
  end

  def get_position(x_coordinate:, y_coordinate:)
    repeated_x = (x_coordinate % @row_length)
    @rows[y_coordinate][repeated_x]
  end

  def position_has_tree?(x_coordinate:, y_coordinate:)
    get_position(x_coordinate: x_coordinate, y_coordinate: y_coordinate) == '#'
  end
end

# Class for moving the Toboggan
class Toboggan
  attr_reader :x, :y, :num_trees

  def initialize(map:, right:, down:)
    @map = map
    @x = 0
    @y = 0
    @num_trees = 0
    @right = right
    @down = down
  end

  def move
    @x += @right
    @y += @down

    # TODO: would be nice if Tobogan did not have knowlodge of column_length
    # as well as a more readle check
    return false if @y >= @map.column_length

    @num_trees += 1 if @map.position_has_tree?(x_coordinate: @x, y_coordinate: @y)
    true
  end

  def move_until_outside_map
    move_until_outside_map if move
  end
end

input = File.readlines('day3_puzzle_input.txt', chomp: true)

map = Map.new(rows: input)
toboggans = [
  Toboggan.new(map: map, right: 1, down: 1),
  Toboggan.new(map: map, right: 3, down: 1),
  Toboggan.new(map: map, right: 5, down: 1),
  Toboggan.new(map: map, right: 7, down: 1),
  Toboggan.new(map: map, right: 1, down: 2)
]
toboggans.each(&:move_until_outside_map)

answer = toboggans.inject(1) { |product, toboggan| product * toboggan.num_trees }

puts answer
