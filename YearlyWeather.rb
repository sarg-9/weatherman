module YearlyWeather
  def self.reportYearly(file, ret)
    d_name = file.split('_')
    dir_name = ''
    dir_name.concat(d_name[0], '_', d_name[1])
    path = "/home/dev/Desktop/weatherman/#{dir_name}"
    highest_temperature = 0
    lowest_temperature = 1000
    highest_humidity = 0
    date_highest_temp = ''
    date_lowest_temp = ''
    date_humid = ''

		Dir.foreach(path) do |file_name|
      next if file_name != file
      monthly_file = File.open("#{path}/#{file}", 'r')
      lines = File.readlines("#{path}/#{file}")
      arr = lines[0].split(',')

      high_temp = 0
      low_temp = 0
      humidity = 0

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

      arr.each do |val|
        if val != 'Max Humidity'
          humidity = humidity.next
        else
          break
        end
      end

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        if highest_temperature < arr[high_temp].to_i
          highest_temperature = arr[high_temp].to_i
          date_highest_temp = arr[0]
        end
        i = i.next
      end

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        if lowest_temperature > arr[low_temp].to_i
          lowest_temperature = arr[low_temp].to_i
          date_lowest_temp = arr[0]
        end
        i = i.next
      end

      i = 1
      while i < lines.length
        arr = lines[i].split(',')
        if highest_humidity < arr[humidity].to_i
          highest_humidity = arr[humidity].to_i
          date_humid = arr[0]
        end
        i = i.next
      end

      if ret[0] < highest_temperature
        ret[0] = highest_temperature
        ret[1] = date_highest_temp
      end
      if ret[2] > lowest_temperature
        ret[2] = lowest_temperature
        ret[3] = date_lowest_temp
      end
      if ret[4] < highest_humidity
        ret[4] = highest_humidity
        ret[5] = date_humid
      end
      monthly_file.close
    end
  end
end
