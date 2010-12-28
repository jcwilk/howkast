require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Howkast::Processor::Users" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../../.howkast'))
    Howkast::configure @config
    @howcast   = Howkast::API.new
    @resources = %w{ videos favorites playlists }
  end

  it "should raise an error if given a non-valid user ID" do
    ->{ @howcast.user :id => 'kreektrebano', :resource => :videos }.should \
      raise_error Howkast::Error::RequestError
  end

  it "should raise an error if given an unrecognized resource" do
    ->{ @howcast.user :id => 'jurisgalang', :resource => :jurisgalang }.should \
      raise_error Howkast::Error::RequestError
  end

  it "should return a User object given a valid user ID" do
    user = @howcast.user :id => 'jurisgalang', :resource => :videos
    user.should be_an_instance_of Howkast::Model::User
  end

  it "should return a User object with the appropriate resource attribute" do
    @resources.each do |resource|
      user = @howcast.user :id => 'howcast', :resource => resource
      user.should be_an_instance_of Howkast::Model::User
      
      examine = ->(resource, attribute, model) do
        list = user.send(attribute)
        list.should be_an_instance_of Array
        list.should_not be_empty
        list.each do |entry|
          entry.should be_an_instance_of model
        end
      end
      
      args = case resource
      when 'videos', 'favorites'
        [resource, :videos, Howkast::Model::Video]
      when 'playlists'
        [resource, :playlists, Howkast::Model::Playlist]
      else
        fail 'dude, you messed up!'
      end
      examine[*args]
    end
  end
end
