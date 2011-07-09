require 'uri'

module Kanye
  class NoKeyError < StandardError; end

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
      "http://#{BASE_URL}/serve/source/" + id + '/' + key
    end
  
    def download!
      raise(NoKeyError, "Couldn't find :key for '#{self}'") if key.blank?
    
      response = HTTParty.get(url, :headers => {'cookie' => cookie})
      raise "Response Code '#{response.code}' - Something has changed." unless response.code == 200
    
    
      print "Attempting to download ", self
      puts "\n\tDownloading song..."
    
      mp3_url = URI.escape(response.parsed_response["url"])
      mp3_response = HTTParty.get(mp3_url)
    
      File.open(filename, "wb") do |f|
        f.write(mp3_response.parsed_response)
      end
    
      set_id3_tags!
    end
    
    def to_s
      "(" + [key, title, artist].join(", ") +  ")"
    end
  
    def filename
      name = [artist,title].join('-').gsub(/[ \/]/, "-").downcase
      File.join(Kanye.download_path, name + ".mp3")
    end
  
    private
  
    def set_id3_tags!
      Mp3Info.open(filename) do |mp3|
        mp3.tag.artist = artist
        mp3.tag.title  = title
      end
    end
  end
end