module Kanye
  class Page
    attr_reader :html, :response, :tracks


    def initialize(path, page=1)
      @response = HTTParty.get url(path, page)
      @tracks   = []
      @cookie   = @response.headers['set-cookie']
      @html     = @response.parsed_response    
      parse_response
    end

    def download_all!
      tracks.each do |current_track|
        history = History.new(Kanye.db_path)
        unless history.exists?(current_track)
          begin
            current_track.download! 
          rescue Mp3InfoError => e
            print e.message
          end
          history.insert(current_track)
          puts "\tInserted song into db"
        end
      end
    end

    def url(path, page=1)
      "http://#{BASE_URL}/"+path+"/"+page.to_s+"?ax=1&ts="+timestamp
    end

    protected

    def parse_response
      html_doc = Nokogiri::HTML(@html)
      ids      = @html.scan /\tid:\'(\w*)\'/
      keys     = @html.scan /\tkey:\s+?\'([\d\w]*)\'/
      artists  = html_doc.css('.track_name .artist').map     { |node| node.content.strip }
      titles   = html_doc.css('.track_name .artist + a').map { |node| node.content.strip }
      [ids, keys, titles, artists].each { |a| a.flatten!; a.reverse! }

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
end
