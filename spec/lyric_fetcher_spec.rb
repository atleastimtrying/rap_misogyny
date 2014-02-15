require File.expand_path '../spec_helper.rb', __FILE__

describe "Lyric Fetcher" do
  subject { LyricFetcher.new }
  before { 
    @faux_eminem = [
      {
        artist: "Eminem",
        url: "http://rapgenius.com/artists/Eminem",
        lines:[
          {
            lyric: 'bitch bitch bitch bitch bitch'
          },
          {
            lyric: 'bitch bitch bitch bitch bitch'
          }
        ]
      },
      { 
        lines:[
          { 
            lyric: 'bastard bastard bastard bastard bastard'
          },
          { 
            lyric: 'bastard bastard bastard bastard bastard'
          }
        ] 
      }
    ]
    RapGenius.stub(:search_by_artist).with('eminem').and_return(@faux_eminem)
  }
  it { should respond_to :get_rating }
  it { subject.get_rating('eminem').should be_a String }
  it 'should call RapGenius.search_by_artist' do
    RapGenius.should_receive(:search_by_artist).with('eminem') { @faux_eminem }
    subject.get_rating('eminem')
  end
end