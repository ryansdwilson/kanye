require 'spec_helper'

describe HypeR do
  describe "#collect_tracks" do
    it "should" do
      HypeR.new('samvincent').tracks.first.download
      1.should == 1
    end
  end
end
