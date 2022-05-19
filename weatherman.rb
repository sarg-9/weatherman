# frozen_string_literal: false

query = ARGV[1].split('/')

require './monthly_weather'
require './yearly_weather'
require './monthly_temperature'

year = query[0]
month = '01'
city = 'idk'
city = query[1] if ARGV[0] == '-e'
if ARGV[0] == '-a' || ARGV[0] == '-c'
  month = query[1]
  city = query[2]
end

find_query = ''
find_query.concat(city, '_', 'weather_', "#{year}_")

months_map = {
  '01' => 'Jan',
  '02' => 'Feb',
  '03' => 'Mar',
  '04' => 'Apr',
  '05' => 'May',
  '06' => 'Jun',
  '07' => 'Jul',
  '08' => 'Aug',
  '09' => 'Sep',
  '10' => 'Oct',
  '11' => 'Nov',
  '12' => 'Dec'
}

if ARGV[0] == '-a'
  find_query.concat(months_map[month])
  find_query.concat('.txt')
  MonthlyWeather.report(find_query)
end

if ARGV[0] == '-e'
  highest_temperature = 0
  lowest_temperature = 1000
  highest_humidity = 0
  ret_arr = [-1, '', -1, '', -1, '']
  months_map.each do |_mon, str_mon|
    yearly_file = "#{find_query}#{str_mon}.txt"
    ret = YearlyWeather.report_yearly(yearly_file, ret_arr)
    if ret[0] > highest_temperature
      highest_temperature = ret[0]
      ret_arr[0] = ret[0]
      ret_arr[1] = ret[1]
    end
    if ret[2] < lowest_temperature
      lowest_temperature = ret[2]
      ret_arr[2] = ret[2]
      ret_arr[3] = ret[3]
    end
    next unless ret[4] > highest_humidity

    highest_humidity = ret[4]
    ret_arr[4] = ret[4]
    ret_arr[5] = ret[5]
  end

  puts "Highest: #{ret_arr[0]}C on #{ret_arr[1]}"
  puts "Lowest:  #{ret_arr[2]}C on #{ret_arr[3]}"
  puts "Humid: #{ret_arr[4]}% on #{ret_arr[5]}"

end

if ARGV[0] == '-c'
  find_query.concat(months_map[month])
  find_query.concat('.txt')
  MonthlyTemperature.high_and_low_temperature(find_query)
end
