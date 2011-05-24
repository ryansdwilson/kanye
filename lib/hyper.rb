require 'httparty'
require 'nokogiri'
require 'mp3info'
require 'sqlite3'

require 'hyper/track'
require 'hyper/history'

class HypeR
  attr_reader :html, :response, :tracks
  
  DEFAULT_CONFIGURATION_PATH = File.expand_path("~/.hyper_rc")
  DEFAULT_DOWNLOAD_PATH = File.expand_path("~/Music/HypeR/")
  DEFAULT_DB_PATH = File.expand_path("~/Music/HypeR/.history.db")
  
  def initialize(path, page=1)
    @response = HTTParty.get url(path, page)
    @tracks   = []
    @cookie   = @response.headers['set-cookie']
    @html     = @response.parsed_response    
    parse_response
  end
  
  def download_all!
    while tracks.size > 0
      current_track = tracks.pop
      history = History.new(DEFAULT_DB_PATH)
      unless history.exists?(current_track)
        current_track.download! 
        history.insert(current_track)
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
    ids      = @html.scan /\tid:\'(\w*)\'/
    keys     = @html.scan /\tkey:\s+?\'([\d\w]*)\'/
    artists  = html_doc.css('.track_name .artist').map     { |node| node.content.strip }
    titles   = html_doc.css('.track_name .artist + a').map { |node| node.content.strip }
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
