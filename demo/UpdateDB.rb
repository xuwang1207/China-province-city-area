#encoding: utf-8

require 'pg'
require 'logger'

class UpdateDB
  def initialize dbname="regions", user="postgres", password="password", host="localhost"
    @conn = PG.connect(:dbname => dbname, :host => host, :port => 5432, :user => user, :password => password)
  end
  
  def insert(id,name,parent_id,level,area_code,zip_code,full_name,longitude,latitude)
    directory_name = "log"
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    logger = Logger.new(directory_name + '/log.log')
    
    sql = "insert into regions(id,name,parent_id,level,area_code,zip_code,full_name,longitude,latitude) VALUES (#{id},'#{name}',#{parent_id},#{level},'#{area_code}','#{zip_code}','#{full_name}',#{longitude},#{latitude});"
    logger.info(sql)
    begin
      @conn.exec(sql)
    rescue => e
      puts "[Error]update_province.#{e}"
    end
  end
    
 

end
