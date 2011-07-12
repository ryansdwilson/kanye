require 'spec_helper'

describe Kanye::Playlist do
  describe 'month' do
    subject { Kanye::Playlist.render "{{month}}" }
    it { should == Time.now.strftime("%B") }
  end

  describe 'year' do
    subject { Kanye::Playlist.render "{{year}}" }
    it { should == Time.now.strftime("%Y") }
  end
end
