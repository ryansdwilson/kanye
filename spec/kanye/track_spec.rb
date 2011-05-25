require 'spec_helper'

describe Track do
  before do
    @track = Track.new(:id => 'id', :key => 'key', :artist => 'Alan Braxe', :title => 'Rubicon', :cookie => 'cookie')
  end
  
  describe "url" do
    it "should contain contain :id and :key" do
      @track.url.should == "http://hypem.com/serve/play/id/key.mp3"
    end
  end
  
  describe "to_s" do
    it "should display the key, artist, and title" do
      @track.to_s.should == "(key, Rubicon, Alan Braxe)"
    end
  end
  
  describe "download!" do
    before do
      HTTParty.stub!(:get)
      File.stub!(:open)
      Mp3Info.stub!(:open)
    end
    
    it "should request mp3 from hypem with cookie" do
      HTTParty.should_receive(:get).with(@track.url, {:headers => {"cookie" => @track.cookie}})
      @track.download!
    end
    
    # This spec could use some love
    it "should set ID3 tags" do
      @track.should_receive(:set_id3_tags!)
      @track.download!
    end
  end
end
