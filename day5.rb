# frozen_string_literal: true

# Class for storing boarding pass and calculating seats
class BoardingPass
  include Comparable
  attr_reader :seat_id

  def <=>(other)
    @seat_id <=> other.seat_id
  end

  def initialize(seat)
    @row = calculate_row(seat[0..6])
    @column = calculate_column(seat[7..9])
    @seat_id = @row * 8 + @column
  end

  def calculate_row(instructions, lower_row = 0, upper_row = 127)
    divide_and_conquer(instructions, lower_row, upper_row)
  end

  def calculate_column(instructions, lower_column = 0, upper_column = 7)
    divide_and_conquer(instructions, lower_column, upper_column)
  end

  # TODO: Make me easier to read?
  def divide_and_conquer(instructions, lower, upper)
    range = upper - lower
    instruction = instructions[0]
    tail = instructions[1..-1]

    case instruction
    when 'F', 'L'

      upper -= ((range + 1) / 2)
      return lower if tail.empty?
    when 'B', 'R'

      lower += ((range + 1) / 2)
      return upper if tail.empty?
    end

    divide_and_conquer(tail, lower, upper)
  end
end


input = File.readlines('day5_puzzle_input.txt', chomp: true)
seats = input.map { |line| BoardingPass.new(line) }

p seats.max.seat_id
