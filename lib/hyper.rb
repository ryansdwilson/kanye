require 'httparty'
require 'nokogiri'
require 'mp3info'
require 'hyper/track'
require 'hyper/history'

class HypeR
  attr_reader :html, :response, :tracks
  
  DEFAULT_DOWNLOAD_PATH = File.expand_path("~/Music/HypeR/")
  DEFAULT_DB_PATH = File.expand_path("~/Music/HypeR/history.db")
  
  def initialize(path, options={})
    @response = HTTParty.get url(path)
    @tracks   = []
    @cookie   = @response.headers['set-cookie']
    @html     = @response.parsed_response
    @@download_path = options[:download]
    @@db_path       = options[:db]
    
    parse_response
  end
  
  def download_all!
    while tracks.size > 0
      current_track = tracks.pop
      unless History.exists?(current_track)
        current_track.download! 
        History.insert(current_track)
        puts "\tInserted song into db"
      end
    end
  end
  
  def url(path, page=1)
    "http://hypem.com/"+path+"/"+page.to_s+"?ax=1&ts="+timestamp
  end
  
  def self.download_path
    @@download_path ||= DEFAULT_DOWNLOAD_PATH
  end
  
  def self.db_path
    @@db_path ||= DEFAULT_DB_PATH
  end
  
  protected
  
  def parse_response
    html_doc = Nokogiri::HTML(@html)
    ids     = @html.scan /\tid:\'(\w*)\'/
    keys    = @html.scan /\tkey:\s+?\'([\d\w]*)\'/
    artists = html_doc.css('.track_name .artist').map          {|node| node.content.strip }
    titles   = html_doc.css('.track_name a:nth-of-type(2)').map {|node| node.content.strip }
    [ids, keys, titles, artists].each(&:flatten!)
    
    ids.each_with_index do |id, i|
      @tracks << Track.new(:id  => ids[i], 
                           :key => keys[i], 
                           :title  => titles[i],
                           :artist => artists[i], 
                           :cookie => @cookie)
    end
  end
  
  def timestamp
    ("%10.10f" % Time.now.utc.to_f).gsub('.','')
  end
end
