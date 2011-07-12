require 'mustache'
module Kanye
  class Playlist < Mustache
    def month
      Time.now.strftime("%B")
    end

    def year
      Time.now.strftime("%Y")
    end
  end
end
