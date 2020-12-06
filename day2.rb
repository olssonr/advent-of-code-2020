class PasswordLine
  def initialize(min_occurence:, max_occurence:, letter:, password:)
    @min_occurence = min_occurence
    @max_occurence = max_occurence
    @letter = letter
    @password = password
  end

  def valid?
    occurence_of_letter = @password.count(@letter)
    return occurence_of_letter >= @min_occurence && occurence_of_letter <= @max_occurence
  end
end

def parse_line(line)
  match = line.match(/(\d+)-(\d+) (\w{1}): (.*)/)
  return PasswordLine.new(min_occurence: match[1].to_i,
                          max_occurence: match[2].to_i,
                          letter: match[3],
                          password: match[4])
end

def parse_lines(lines)
  password_lines = []
  lines.each do |line|
    password_lines << (parse_line line)
  end
  return password_lines
end

input = File.readlines "day2_puzzle_input.txt"
parsed_lines = parse_lines(input)
num_valid_passwords = parsed_lines.count { |line| line.valid? }
puts num_valid_passwords

#parsed_lines.each do |line|
  #puts line.valid?
  #p line
#end