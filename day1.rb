# frozen_string_literal: true

def fetch_first_2_elements_with_sum(list, sum)
  head = list.shift
  return unless head

  list.each do |element|
    return head, element if head + element == sum
  end

  fetch_first_2_elements_with_sum(list, sum)
end

input = (File.readlines 'day1_puzzle_input.txt').map!(&:to_i)
elements = fetch_first_2_elements_with_sum input, 2020
puts(elements[0] * elements[1])
