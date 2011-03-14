require 'httparty'

class HypeR
  attr_reader :html, :response, :tracks
  
  def initialize(path)
    @response = HTTParty.get("http://hypem.com/"+path+"/1?ax=1&ts="+timestamp)
    @tracks   = []
    @cookie   = @response.headers['set-cookie']
    @html     = @response.parsed_response
    
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
  
  protected
  
  def parse_response
    ids     = @html.scan /\tid:\'(\w*)\'/
    keys    = @html.scan /\tkey:\s+?\'([\d\w]*)\'/
    songs   = @html.scan /\tsong:\'(.*)\'/
    artists = @html.scan /\tartist:\'(.*)\'/
    [ids, keys, songs, artists].each(&:flatten!)
    
    ids.each_with_index do |id, i|
      @tracks << Track.new(:id => ids[i], 
                           :key => keys[i], 
                           :title => songs[i],
                           :artist => artists[i], 
                           :cookie => @cookie)
    end
  end
  
  # seconds from epoch - UNIX
  def timestamp
    ("%10.10f" % Time.now.utc.to_f).gsub('.','')
  end
end

class Track
  def initialize(params={})
    @id     = params[:id]
    @key    = params[:key]
    @title  = params[:title]
    @artist = params[:artist]
    @cookie = params[:cookie]
  end
  
  attr_reader :id, :key, :title, :artist, :cookie
  
  def url
    'http://hypem.com/serve/play/'+ id + '/' + key + ".mp3"
  end
  
  def download!
    response = HTTParty.get(url, :headers => {'cookie' => cookie})
    puts "Attempting to download ", self
    puts "\tDownloading song..."
    File.open("/Users/samvincent/Desktop/"+title+".mp3", "wb") do |f|
      f.write(response.parsed_response)
    end
  end
    
  def to_s
    "("+key+", "+title+", "+artist+")"
  end
end

class History
  class << self
    def db
      db = SQLite3::Database.new( "/Users/samvincent/Desktop/hyper_history.db" )
      # db.execute("CREATE TABLE tracks (id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT);")
    end
    
    def insert(track)
      db.execute("insert into tracks values (?, ?)", [nil, track.id])
    end
    
    def exists?(track)
      db.execute("select * from tracks where key=?", track.id).any?
    end
  end
end