require 'spec_helper'

describe Kanye::Track do
  before do
    @track = Kanye::Track.new(:id => 'id', :key => 'key', :artist => 'Alan Braxe', :title => 'Rubicon', :cookie => 'cookie')
  end
  
  describe "url" do
    it "should contain contain :id and :key" do
      @track.url.should == "http://#{Kanye::BASE_URL}/serve/source/id/key"
    end
  end
  
  describe "to_s" do
    it "should display the key, artist, and title" do
      @track.to_s.should == "(key, Rubicon, Alan Braxe)"
    end
  end
  
  describe "download!" do
    before do
      HTTParty.stub!(:get) { mock(:response, :parsed_response => {'url' => ''}, :code => 200) }
      File.stub!(:open)
      Mp3Info.stub!(:open)
    end
    
    it "should request mp3 url with cookie" do
      HTTParty.should_receive(:get).with(@track.url, {:headers => {"cookie" => @track.cookie}})
      @track.download!
    end
    
    it "should url escape returned url in mp3 download call" do
      unescaped_url = "http://offtheradarmusic.com/audio/Synthetiseur (Bestrack Nostalgia Remix).mp3"
      escaped_url   = "http://offtheradarmusic.com/audio/Synthetiseur%20(Bestrack%20Nostalgia%20Remix).mp3"
      response = mock(:parsed_response => {'url' => unescaped_url}, :code => 200)
      HTTParty.stub!(:get).once.and_return(response)
      HTTParty.should_receive(:get).with(escaped_url).once
      @track.download!
    end
    
    # This spec could use some love
    it "should set ID3 tags" do
      @track.should_receive(:set_id3_tags!)
      @track.download!
    end
  end
end
