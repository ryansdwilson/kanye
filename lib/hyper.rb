require 'httparty'
require 'hyper/track'
require 'hyper/history'

class HypeR
  attr_reader :html, :response, :tracks
  
  DEFAULT_DOWNLOAD_PATH = "~/Music/HypeR/"
  DEFAULT_DB_PATH = "~/Music/HypeR/history.db"
  
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
  
  def url(path, pages=1)
    "http://hypem.com/"+path+"/"+pages+"?ax=1&ts="+timestamp
  end
  
  def self.download_path
    @@download_path ||= DEFAULT_DOWNLOAD_PATH
  end
  
  def self.db_path
    @@db_path ||= DEFAULT_DB_PATH
  end
  
  protected
  
  def parse_response
    ids     = @html.scan /\tid:\'(\w*)\'/
    keys    = @html.scan /\tkey:\s+?\'([\d\w]*)\'/
    songs   = @html.scan /\tsong:\'(.*)\'/
    artists = @html.scan /\tartist:\'(.*)\'/
    [ids, keys, songs, artists].each(&:flatten!)
    
    ids.each_with_index do |id, i|
      @tracks << Track.new(:id  => ids[i], 
                           :key => keys[i], 
                           :title  => songs[i],
                           :artist => artists[i], 
                           :cookie => @cookie)
    end
  end
  
  def timestamp
    ("%10.10f" % Time.now.utc.to_f).gsub('.','')
  end
end
