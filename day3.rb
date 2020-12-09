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
  attr_reader :x, :y, :num_tress

  def initialize(map:)
    @map = map
    @x = 0
    @y = 0
    @num_tress = 0
  end

  def move
    @x += 3
    @y += 1

    # TODO: would be nice if Tobogan did not have knowlodge of column_length
    # as well as a more readle check
    return false if @y >= @map.column_length

    @num_tress += 1 if @map.position_has_tree?(x_coordinate: @x, y_coordinate: @y)
    true
  end

  def move_until_outside_map
    move_until_outside_map if move
  end
end

input = File.readlines('day3_puzzle_input.txt', chomp: true)

map = Map.new(rows: input)
toboggan = Toboggan.new(map: map)
toboggan.move_until_outside_map

puts toboggan.num_tress
