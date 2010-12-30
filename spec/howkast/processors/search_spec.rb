require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Howkast::Processor::Search" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end
  
  it "should always return a Search object" do
    %w{ howcast kreektrebano }.each do |query|
      search = @howcast.search :query => query
      search.should be_an_instance_of Howkast::Model::Search
      search.should respond_to :videos
      search.should respond_to :title
      (search.title =~ /#{query}/u).should_not be nil
      list = search.videos
      list.should be_an_instance_of Array
      list.should_not be_empty if query == 'howcast'
      list.should be_empty     if query == 'kreektrebano'
      list.each do |entry|
        entry.should be_an_instance_of Howkast::Model::Video
      end
    end
  end
end
