require "date"
require "prime"

print "The start date you want is (YYYYMMDD): "
start_date = gets.strip.delete(" ")
print "The end date you want is (YYYYMMDD): "
end_date = gets.strip.delete(" ")

begin
  date_input_start = Date.parse(start_date).strftime("%Y%m%d")
  start_number = date_input_start.to_i
  puts "===> Start number is #{start_number}"
  date_input_end = Date.parse(end_date).strftime("%Y%m%d")
  end_number = date_input_end.to_i
  puts "===> End number is #{end_number}"
  raise ArgumentError if start_number > end_number
rescue ArgumentError => e
  puts "[ERROR] Have errors with input date, please try again!"
  return
end

def valid_date? date
  begin
    Date.parse date
    true
  rescue => e
    false
  end
end

def filter_prime_by_day first, last
  valid_date_range = (first..last).select {|date| valid_date?(date)}
  valid_date_range.select{|date| Prime.prime?(Date.parse(date).day)}
end

def generate_result first, last
  filtered_date_range = filter_prime_by_day(first, last)
  filtered_date_range.select! do |date|
    (0..5).each do |i|
      break unless Prime.prime?(date.to_s[i..-1].to_i)
      true
    end
  end

  if filtered_date_range.empty?
    puts "Does not have any prime number in this date range. Please try again!"
  else
    puts "Result is #{filtered_date_range}"
  end
end

generate_result(date_input_start, date_input_end)
