# frozen_string_literal: true

# Line in the password database
class PasswordLine
  def initialize(min_occurence:, max_occurence:, letter:, password:)
    @min_occurence = min_occurence
    @max_occurence = max_occurence
    @letter = letter
    @password = password
  end

  def valid?
    occurence_of_letter = @password.count(@letter)
    occurence_of_letter >= @min_occurence && occurence_of_letter <= @max_occurence
  end
end

# Line in the password database
class PasswordLine2
  def initialize(position1:, position2:, letter:, password:)
    @position1 = position1
    @position2 = position2
    @letter = letter
    @password = password
  end

  def valid?
    char1 = @password[@position1 - 1]
    char2 = @password[@position2 - 1]

    (char1 == @letter || char2 == @letter) && char1 != char2
  end
end

def parse_line(line)
  match = line.match(/(\d+)-(\d+) (\w{1}): (.*)/)
  PasswordLine2.new(position1: match[1].to_i,
                    position2: match[2].to_i,
                    letter: match[3],
                    password: match[4])
end

def parse_lines(lines)
  password_lines = []
  lines.each do |line|
    password_lines << (parse_line line)
  end
  password_lines
end

input = File.readlines 'day2_puzzle_input.txt'
parsed_lines = parse_lines(input)
num_valid_passwords = parsed_lines.count(&:valid?)
puts num_valid_passwords
