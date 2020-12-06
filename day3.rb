class Map
  attr_reader :map, :column_length, :row_length

  def initialize(rows:)
    @rows = rows
    @row_length = @rows[0].length
    @column_length = @rows.length
  end

  def get_position(x:, y:)
    repeated_x = (x % @row_length)
    return @rows[y][repeated_x]
  end

  def position_has_tree?(x:, y:)
    return self.get_position(x: x, y: y) == "#"
  end
end

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
    #puts "x:#{@x} y:#{@y} = #{@map.get_position(x: @x, y: @y)}"

    @num_tress += 1 if @map.position_has_tree?(x: @x, y: @y)
    return true
  end

  def move_until_outside_map
    move_until_outside_map if move
  end
end

input = File.readlines("day3_puzzle_input.txt", chomp: true)

map = Map.new(rows: input)
toboggan = Toboggan.new(map: map)
toboggan.move_until_outside_map

puts toboggan.num_tress