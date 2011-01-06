require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Howkast::Processor::Videos" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end

  it "should raise an error if given a non-valid video ID" do
    lambda{ @howcast.video :id => '9999999999999999999999999' }.should \
    raise_error Howkast::Error::RequestError
  end

  it "should return a Video object given a valid video ID" do
    video = @howcast.video :id => 6570
    video.should be_an_instance_of Howkast::Model::Video
  end

  it "should return an array of Video objects" do
    categories = @howcast.categories.map{ |category| category.permalink.split('/').last }
    categories = categories[0 .. 9]
    categories << nil
    categories.each do |category|
      %w{ most_viewed most_recent top_rated }.each do |sort|
        %w{ all howcast_studios }.each do |filter|
          opts = { :sort => sort, :filter => filter }
          opts[:category] = category unless category.nil?
          list = @howcast.videos opts
          list.should be_an_instance_of Array
          list.each do |entry| 
            entry.should be_an_instance_of Howkast::Model::Video
          end
        end
      end
    end
  end
end
