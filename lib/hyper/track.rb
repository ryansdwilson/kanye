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
    
    print "Attempting to download ", self
    puts "\n\tDownloading song..."
    
    File.open(HypeR.download_path+title+".mp3", "wb") do |f|
      f.write(response.parsed_response)
    end
  end
    
  def to_s
    "("+key+", "+title+", "+artist+")"
  end
end
