module Kanye
  class History
    attr_reader :db
    def initialize(db_file)
      @db = SQLite3::Database.new(db_file)
    end
  
    def insert(track)
      db.execute("insert into tracks values (?, ?)", [nil, track.id])
    end
  
    def exists?(track)
      db.execute("select * from tracks where key=?", track.id).any?
    end
  end
end
