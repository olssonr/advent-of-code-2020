# frozen_string_literal: true

# Class for storing passport fields and validation
class Passport
  def initialize(fields)
    @fields = fields
    @required_fields = %w[byr iyr eyr hgt hcl ecl pid]
  end

  def valid?
    @required_fields.all? { |required| @fields.include? required }
  end
end

def lines_to_passport_strings(lines)
  passport_chunks = lines.chunk do |line|
    !line.empty?
  end

  passport_strings = []
  passport_chunks.each do |chunk|
    passport_strings.append(chunk[1].join(' ')) if chunk[0]
  end

  passport_strings
end

def passport_strings_to_passports(passport_strings)
  passport_strings.map do |string|
    field_hash = {}
    string.split(' ').each do |key_and_value|
      key = key_and_value[0..2]
      value = key_and_value[4..-1]
      field_hash[key] = value
    end

    Passport.new(field_hash)
  end
end

input = File.readlines('day4_puzzle_input.txt', chomp: true)
passport_strings = lines_to_passport_strings(input)
passports = passport_strings_to_passports(passport_strings)

p passports.count(&:valid?)
