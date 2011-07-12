require 'spec_helper'
require 'appscript'

describe Kanye::ITunes do
  include Appscript
  KANYE_TEST = 'KANYE_TEST'
  
  describe :add_to_playlist do
    let(:list) { Kanye::ITunes.new.playlist(KANYE_TEST) }
    after  { begin app('iTunes').delete(list); rescue; end }
    
    context "when file found" do
      context "and playlist is June" do
        let(:file) { File.expand_path('spec/data/super.mp3') }
        
        before do
          Kanye::ITunes.new.add_to_playlist(file, KANYE_TEST)
        end
        
        it "should add song to playlist" do
          tracks = app('iTunes').user_playlists[its.name.eq(KANYE_TEST)].first.tracks.name.get
          tracks.should include('super')
        end
      end
    end
  end
  
  describe :playlist do
    let(:list) { Kanye::ITunes.new.create_playlist(KANYE_TEST) }
    before { list }
    after  { begin app('iTunes').delete(list); rescue; end }
    
    context "playlist is found" do
      it "should return appscript reference" do
        Kanye::ITunes.new.playlist(KANYE_TEST).class.should == Appscript::Reference 
      end
    end
    
    context "playlist can not be found" do
      before  { app('iTunes').delete list }
      it "should return nil" do
        Kanye::ITunes.new.playlist(KANYE_TEST).should be_nil
      end
    end
  end
end
