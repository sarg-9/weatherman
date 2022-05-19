# frozen_string_literal: false

# module for monthly weather
module MonthlyWeather
  def self.report(file)
    d_name = file.split('_')
    dir_name = ''
    dir_name.concat(d_name[0], '_', d_name[1])
    path = "/home/dev/Desktop/weatherman/#{dir_name}"
    Dir.foreach(path) do |file_name|
      next if file_name != file

      open_file(file, path)
    end
  end

  def self.open_file(file, path)
    monthly_file = File.open("#{path}/#{file}", 'r')
    lines = File.readlines("#{path}/#{file}")
    avg_max_temp = max_temp(lines)
    avg_low_temp = low_temp(lines)
    avg_humid = avg_humidity(lines)
    arr = lines[0].split(',')
    summary = [highest_average_temperature(lines, arr, avg_max_temp),
               lowest_average_temperature(lines, arr, avg_low_temp), average_humidity(lines, arr, avg_humid)]
    puts "Highest Average: #{summary[0]}C \nLowest Average: #{summary[1]}C \nAverage Humidity: #{summary[2]}%"
    monthly_file.close
  end

  def self.max_temp(lines)
    arr = lines[0].split(',')
    avg_max_temp = 0
    arr.each do |val|
      val != 'Max TemperatureC' ? avg_max_temp = avg_max_temp.next : break
    end
    avg_max_temp
  end

  def self.low_temp(lines)
    arr = lines[0].split(',')
    avg_low_temp = 0
    arr.each do |val|
      val != 'Min TemperatureC' ? avg_low_temp = avg_low_temp.next : break
    end
    avg_low_temp
  end

  def self.avg_humidity(lines)
    arr = lines[0].split(',')
    count = 0
    arr.each do |val|
      val != 'Max Humidity' ? count = count.next : break
    end
    count
  end

  def self.highest_average_temperature(lines, arr, avg_max_temp)
    i = 1
    count = 0
    highest_average_temperature = 0
    while i < lines.length
      arr = lines[i].split(',')
      highest_average_temperature += arr[avg_max_temp].to_i
      count = count.next
      i = i.next
    end
    highest_average_temperature / count
  end

  def self.lowest_average_temperature(lines, arr, avg_low_temp)
    i = 1
    count = 0
    lowest_average_temperature = 0
    while i < lines.length
      arr = lines[i].split(',')
      lowest_average_temperature += arr[avg_low_temp].to_i
      count = count.next
      i = i.next
    end
    lowest_average_temperature / count
  end

  def self.average_humidity(lines, arr, avg_humid)
    i = 1
    count = 0
    average_humidity = 0
    while i < lines.length
      arr = lines[i].split(',')
      average_humidity += arr[avg_humid].to_i
      count = count.next
      i = i.next
    end
    average_humidity / count
  end
end
