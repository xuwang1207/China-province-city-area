#!/usr/bin/ruby
#encoding: utf-8
$LOAD_PATH << '.'
require 'rubyXL'
require 'UpdateDB'

# 获取数据库信息参数
def parse_xlsx file_name
  if file_name.nil?
    return nil
  end
  
  begin
    workbook = RubyXL::Parser.parse(file_name)
    update_db = UpdateDB.new
    worksheet = workbook[0]
    worksheet.each do |row|
      #ID  Name  ParentId  ShortName LevelType CityCode  ZipCode MergerName  lng Lat
      id = row[0].nil? ? "" : row[0].value
      name = row[1].nil? ? "" : row[1].value
      parent_id = row[2].nil? ? "" : row[2].value
      level = row[4].nil? ? "" : row[4].value
      area_code = row[5].nil? ? "" : row[5].value
      zip_code = row[6].nil? ? "" : row[6].value
      full_name = row[7].nil? ? "" : row[7].value
      longitude = row[8].nil? ? "" : row[8].value
      latitude = row[9].nil? ? "" : row[9].value
      update_db.insert(id,name,parent_id,level,area_code,zip_code,full_name,longitude,latitude)
    end
    rescue => e
    puts "Error : #{e}"
  end
end


puts "Start insert #{Time.now}"
parse_xlsx ARGV[0]
puts "End insert #{Time.now}"