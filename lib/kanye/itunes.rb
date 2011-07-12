require 'appscript'

module Kanye
  class ITunes
    include Appscript
    
    def add_to_playlist(file, playlist_name)
      list = playlist(playlist_name) || create_playlist(playlist_name)
      raise "Playlist could not be found or created" unless list
      track = itunes.add MacTypes::Alias.path(file)
      track.duplicate(:to => list) if track
    end
    
    def playlist(name)
      itunes.user_playlists[its.name.eq(name)].get.first
    end
    
    def create_playlist(name)
      itunes.make(:new => :user_playlist, :with_properties => {:name => name})
    end
    
    private
    
    def itunes
      app('iTunes')
    end
  end
end
