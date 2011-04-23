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
    
    File.open(filename, "wb") do |f|
      f.write(response.parsed_response)
    end
    
    set_id3_tags!
  end
    
  def to_s
    "("+key+", "+title+", "+artist+")"
  end
  
  def filename
    name = [artist,title].join('-').gsub(" ","-").downcase
    File.join(HypeR.download_path, name+".mp3")
  end
  
  def set_id3_tags!
    Mp3Info.open(filename, :encoding => 'utf-8') do |mp3|
      mp3.tag.artist = artist
      mp3.tag.title  = title
    end
  end
end
