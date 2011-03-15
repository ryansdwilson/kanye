class History
  class << self
    def db
      db = SQLite3::Database.new( "/Users/samvincent/Desktop/history.db" )
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