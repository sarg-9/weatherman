# frozen_string_literal: false

# module for yearly weather
module YearlyWeather
  def self.report_yearly(file, ret)
    d_name = file.split('_')
    dir_name = ''
    dir_name.concat(d_name[0], '_', d_name[1])
    path = "/home/dev/Desktop/weatherman/#{dir_name}"
    Dir.foreach(path) do |file_name|
      next if file_name != file

      ret = open_file(file, path)
    end
    ret
  end

  def self.open_file(file, path)
    lines = File.readlines("#{path}/#{file}")
    arr = lines[0].split(',')
    h_temp = h_humidity = 0
    l_temp = 1000
    highest_temp = highest_temperature(lines, 1, arr, h_temp, max_temp(arr))
    lowest_temp = lowest_temperature(lines, 1, arr, l_temp, low_temp(arr))
    highest_humidity = humidity(lines, 1, arr, h_humidity, humidity_index(arr))
    change_valeus(highest_temp, h_temp, lowest_temp, l_temp, highest_humidity,
                  h_humidity)
  end

  def self.max_temp(arr)
    high_temp = 0
    arr.each do |val|
      val != 'Max TemperatureC' ? high_temp = high_temp.next : break
    end
    high_temp
  end

  def self.low_temp(arr)
    low_temp = 0
    arr.each do |val|
      val != 'Min TemperatureC' ? low_temp = low_temp.next : break
    end
    low_temp
  end

  def self.humidity_index(arr)
    humidity = 0
    arr.each do |val|
      val != 'Max Humidity' ? humidity = humidity.next : break
    end
    humidity
  end

  def self.highest_temperature(lines, ind, arr, highest_temperature, high_temp)
    date_highest_temp = ''
    while ind < lines.length
      arr = lines[ind].split(',')
      if arr[high_temp].to_i > highest_temperature
        highest_temperature = arr[high_temp].to_i
        date_highest_temp = arr[0]
      end
      ind = ind.next
    end
    [highest_temperature, date_highest_temp]
  end

  def self.lowest_temperature(lines, ind, arr, lowest_temperature, low_temp)
    date_lowest_temp = ''
    while ind < lines.length
      arr = lines[ind].split(',')
      if arr[low_temp].to_i < lowest_temperature
        lowest_temperature = arr[low_temp].to_i
        date_lowest_temp = arr[0]
      end
      ind = ind.next
    end
    [lowest_temperature, date_lowest_temp]
  end

  def self.humidity(lines, ind, arr, highest_humidity, humidity)
    while ind < lines.length
      arr = lines[ind].split(',')
      highest_humidity = arr[humidity].to_i if arr[humidity].to_i > highest_humidity
      ind = ind.next
    end
    [highest_humidity, arr[0]]
  end

  def self.change_valeus(highest_temperature, highest_temp, lowest_temperature, lowest_temp, highest_humidity, humidity)
    highest_temperature[0] = highest_temp if highest_temperature[0] < highest_temp
    lowest_temperature[0] = lowest_temp if lowest_temperature[0] > lowest_temp
    highest_humidity[0] = humidity if highest_humidity[0] < humidity
    [highest_temperature[0], highest_temperature[1], lowest_temperature[0], lowest_temperature[1], highest_humidity[0],
     highest_humidity[1]]
  end
end
