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
  
  def download
    response = HTTParty.get(url, :headers => {'cookie' => cookie})
    puts "Attempting to download..."
    print self
    File.open("/Users/samvincent/Desktop/"+title+".mp3", "wb") do |f|
      f.write(response.parsed_response)
    end
  end
  
  def to_s
    "("+key+", "+title+", "+artist+")"
  end
end