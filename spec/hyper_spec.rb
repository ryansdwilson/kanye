require 'spec_helper'

describe HypeR do
  describe "#collect_tracks" do
    it "should" do
      HypeR.new('samvincent').download_all!
      1.should == 1
    end
  end
end
