require 'spec_helper'

describe Kanye do
  describe 'config' do
    context 'when using default config' do
      subject { Kanye }
      its(:download_path) { should == File.expand_path('~/Music/Kanye/')}
      its(:db_path)       { should == File.expand_path('~/Music/Kanye/.history.db')}
      its(:id3_comment)   { should == 'downloaded with kanye' }
    end

    context 'when using custom config' do
      it 'should set new download path' do
        Kanye.download_path = '~/Music/iTunes/Automatically add to iTunes'
        Kanye.db_path = '~/Music/Kanye/.kanye_history.db'
        Kanye.download_path.should == File.expand_path('~/Music/iTunes/Automatically add to iTunes')
        Kanye.db_path.should == File.expand_path('~/Music/Kanye/.kanye_history.db')
      end
    end
  end

end

describe Kanye::Page do
  describe '#parse_response' do
    let(:html) { File.open('spec/data/sample.html', 'r').read }
    
    before do
      resp = mock(:response, 
                  :parsed_response => html, 
                  :headers         => {'set-cookie' => 'yesplease'})
                  
      HTTParty.stub!(:get).and_return(resp)
    end
    
    let(:kanye) { Kanye::Page.new('test') }
    
    describe 'format strings' do
      results = [
        ["Rusko","Jahova","ta42","9ecc8d868239653e7c99a6891a878e01","yesplease"],
        ["Rusko","Everyday","19n3n","c63b38f6714b7273a2c3f28c3e86ea54","yesplease"],
        ["Washed Out feat. Caroline Polachek","You and I","12xxd","c9d3b9a12d0979becf154821c191b151","yesplease"],
        ["Le Castle Vania","DJ Falcon + Thomas Bangalter Together (Le Castle Vania + Computer Club's Summer Bootleg Mix)","1av33","87c503dcc8bc46761a56b7bedfbb1697","yesplease"],
        ["Earl Da Grey","Kick It","1ar7m","dfd3c3f06d2fc5b5a4e0bf22f91982bc","yesplease"],
        ["Earl Da Grey","Heavenly Motion","1ar7k","0b9ccedbaacdb63c4c7d7344a149cde8","yesplease"],
        ["Earl Da Grey","Millionaire Radio","1ar7g","8607e44740e600769d4e3fa2e8ded210","yesplease"],
        ["Earl Da Grey","Taboo","1ar7h","734faa71e9072f3e7fa6ead9909e93cf","yesplease"],
        ["James Varnish","Compare (Lifelike Remix)","1armr","a4fe6cc8ce6b210def2191cc9b705ed3","yesplease"],
        ["Jamaica","I Think I Like U 2 (Breakbot Remix)","1161m","baf3e68ccf6ae0ccc7be7f0ef1554969","yesplease"],
        ["Radiohead","Supercollider","1aqn0","db5724fa6e4c78dcfa49abed5320142a","yesplease"],
        ["Dillon Francis","Beautician","1ag12","d6e55add48919d72c08bb11fc81d998d","yesplease"],
        ["The Human League","Never Let Me Go (Aeroplane Remix Edit)","19men","d53d93bd145589d4a9bd649cdd8179da","yesplease"],
        ["His Majesty Andre","Clubs","1as5w","bb17f53d899643c92020f7f1797b36a5","yesplease"],
        ["Cassian","Getting High (Original Mix)","1as5v","2182d0f18240433b372d8febd08b8dd3","yesplease"],
        ["Les Rythmes Digitales","About Funk","1as5z","3b8198e97bda14db73254b6febbdf42d","yesplease"],
        ["BeatauCue","Behold","1873c","1113b0b95c8ea988661b8bbbf5260d45","yesplease"],
        ["Toddla T","Take It Back (Dillon Francis Remix)","1ancc","ef8efa46115c08cef60b7241c7d82c7c","yesplease"],
        ["Danger Granger","Daniel is a Wild Cat (Porter Robinson vs Bat For Lashes)","1asad","65257400b1a1266adb3173f029bbb1a8","yesplease"],
        ["DEFEP","Rolling it Right (Afrojack vs Adele)","1asae","63cbcb3a740e1ad0cb7163b23e33a9d6","yesplease"]
      ]
      results.reverse!.each_with_index do |track, index|
        describe "track No. #{index+1}" do
          subject { kanye.tracks[index] }
          its(:artist) { should == results[index][0] }
          its(:title)  { should == results[index][1] }
          its(:id)     { should == results[index][2] }
          its(:key)    { should == results[index][3] }
          its(:cookie) { should == "yesplease" }
        end
      end
    end
  end
end
