# frozen_string_literal: true

# Class for storing custom declaration answers for a group
class Group
  attr_reader :answer_string

  def initialize(answer_string)
    @answer_string = answer_string
  end

  def num_yes
    @answer_string.chars.uniq.count
  end
end

def lines_to_answer_strings(lines)
  groups = lines.chunk do |line|
    !line.empty?
  end

  answer_strings = []
  groups.each do |chunk|
    answer_strings.append(chunk[1].join) if chunk[0]
  end

  answer_strings
end

input = File.readlines('day6_puzzle_input.txt', chomp: true)
answer_strings = lines_to_answer_strings(input)

groups = []
answer_strings.each do |string|
  groups.append(Group.new(string))
end

total_yes = groups.sum(&:num_yes)
p total_yes
