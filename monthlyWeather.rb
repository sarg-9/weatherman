require 'colorize'

module MonthlyWeather
  def self.report(file)
    d_name = file.split('_')
    dir_name = ''
    dir_name.concat(d_name[0], '_', d_name[1])
    path = "/home/dev/Desktop/weatherman/#{dir_name}"
    Dir.foreach(path) do |file_name|
      next if file_name != file

      puts "Weather Report for #{file}"
      monthly_file = File.open("#{path}/#{file}", 'r')
      lines = File.readlines("#{path}/#{file}")
      arr = lines[0].split(',')

      avg_max_temp = 0
      avg_low_temp = 0
      avg_humidity = 0
      avg_humidity = 0

      arr.each do |val|
        if val != 'Max TemperatureC'
          avg_max_temp = avg_max_temp.next
        else
          break
        end
      end
      arr.each do |val|
        if val != 'Min TemperatureC'
          avg_low_temp = avg_low_temp.next
        else
          break
        end
      end
      arr.each do |val|
        if val != 'Max Humidity'
          avg_humidity = avg_humidity.next
        else
          break
        end
      end

      highest_average = 0
      lowest_average = 0
      average_humidity = 0

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        highest_average += arr[avg_max_temp].to_i

        avg_humidity = avg_humidity.next
        i = i.next
      end
      highest_average /= avg_humidity
      avg_humidity = 0

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        lowest_average += arr[avg_low_temp].to_i

        avg_humidity = avg_humidity.next
        i = i.next
      end
      lowest_average /= avg_humidity
      avg_humidity = 0

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        average_humidity += arr[avg_humidity].to_i

        avg_humidity = avg_humidity.next
        i = i.next
      end
      average_humidity /= avg_humidity

      puts "Highest Average: #{highest_average}C"
      puts "Lowest Average: #{lowest_average}C"
      puts "Average Humidity: #{average_humidity}%"

      monthly_file.close

      # more code
    end
  end

  def self.high_And_Low_Temperature(file)
    d_name = file.split('_')
    dir_name = ''
    dir_name.concat(d_name[0], '_', d_name[1])
    p dir_name

    path = "/home/dev/Desktop/weatherman/#{dir_name}"
    Dir.foreach(path) do |file_name|
      next if file_name != file

      puts "Weather Report for #{file}"
      monthly_file = File.open("#{path}/#{file}", 'r')
      lines = File.readlines("#{path}/#{file}")
      arr = lines[0].split(',')

      high_temp = 0
      low_temp = 0

      arr.each do |val|
        if val != 'Max TemperatureC'
          high_temp = high_temp.next
        else
          break
        end
      end

      arr.each do |val|
        if val != 'Min TemperatureC'
          low_temp += 1
        else
          break
        end
      end

      highest_temperature = 0
      lowest_temperature = 1000

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        highest_temperature < arr[high_temp].to_i ? highest_temperature = arr[high_temp].to_i : highest_temperature = highest_temperature
        i = i.next
      end

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        lowest_temperature = lowest_temperature > arr[low_temp].to_i ? arr[low_temp].to_i : lowest_temperature
        i = i.next
      end

      out = ''
      i = lowest_temperature
      while i.positive?
        out.concat('+')
        i -= 1
      end
      out1 = ''
      i = highest_temperature
      while i.positive?
        out1.concat('+')
        i -= 1
      end
      puts '01 ' + out.to_s.blue + out1.to_s.red + " #{lowest_temperature}C - #{highest_temperature}C"
      monthly_file.close

      # more code
    end
  end
end
