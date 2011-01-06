require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Howkast::Processor::Playlists" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end
  
  it "should raise an error if given a non-valid playlist ID" do
    lambda{ @howcast.playlist :id => '9999999999999999999999999' }.should \
      raise_error Howkast::Error::RequestError
  end

  it "should return a Playlist object given a valid playlist ID" do
    playlist = @howcast.playlist :id => 4261
    playlist.should be_an_instance_of Howkast::Model::Playlist
    playlist.should respond_to :videos
    list = playlist.videos
    list.should be_an_instance_of Array
    list.should_not be_empty
    list.each do |entry|
      entry.should be_an_instance_of Howkast::Model::Video
    end
  end
end
