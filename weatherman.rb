query = ARGV[1].split('/')

require './monthlyWeather'
require './YearlyWeather'

year = query[0]
month = '01'
city = 'idk'
city = query[1] if ARGV[0] == '-e'
if ARGV[0] == '-a' || ARGV[0] == '-c'
  month = query[1]
  city = query[2]
end

find_query = ''
find_query = find_query.concat(city, '_', 'weather_', year + '_')

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
  highest_average = 0
  lowest_average = 0
  average_humidity = 0
  ret_arr = [-1, '', -1, '', -1, '']
  months_map.each do |_mon, str_mon|
    yearly_file = find_query + str_mon + '.txt'
    YearlyWeather.reportYearly(yearly_file, ret_arr)
  end
  puts "Highest: #{ret_arr[0]}C on #{ret_arr[1]}"
  puts "Lowest:  #{ret_arr[2]}C on #{ret_arr[3]}"
  puts "Humid: #{ret_arr[4]}% on #{ret_arr[5]}"

end

if ARGV[0] == '-c'
  find_query.concat(months_map[month])
  find_query.concat('.txt')
  MonthlyWeather.high_And_Low_Temperature(find_query)
end
