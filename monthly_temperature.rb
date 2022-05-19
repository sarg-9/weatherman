# frozen_string_literal: false

# module for monthly temperature
module MonthlyTemperature
  def self.high_and_low_temperature(file)
    require 'colorize'
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
    max_temp = max_temp(lines)
    low_temp = low_temp(lines)
    pata_nahi(lines, 1, 0, max_temp, low_temp)
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

  def self.pata_nahi(lines, ind, date, high_temp, low_temp)
    while ind < lines.length
      arr = lines[ind].split(',')
      highest_temperature = arr[high_temp].to_i
      lowest_temperature = arr[low_temp].to_i
      ind = ind.next
      show_report(highest_temperature, lowest_temperature, date)
      date = date.next
    end
  end

  def self.output_low_temp(lowest_temperature)
    out = ''
    j = lowest_temperature
    while j.positive?
      out.concat('+')
      j -= 1
    end
    out
  end

  def self.output_high_temp(highest_temperature)
    out1 = ''
    j = highest_temperature
    while j.positive?
      out1.concat('+')
      j -= 1
    end
    out1
  end

  def self. show_report(highest_temperature, lowest_temperature, date)
    out = output_high_temp(lowest_temperature)
    out1 = output_low_temp(highest_temperature)
    puts date.to_s + out.blue + out1.red + " #{lowest_temperature}C - #{highest_temperature}C"
  end
end
