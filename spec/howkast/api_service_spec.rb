require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Howkast::API::service" do
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end
  
  it "should be able to list supported services" do
    services = Howkast::API.services
    services.should be_an_instance_of Array
    services.should_not be_empty
  end
  
  it "should provide implementation for the services it supports" do
    services = Howkast::API.services
    services.should be_an_instance_of Array
    services.should_not be_empty
    howcast = Howkast::API.new
    services.each do |service|
      howcast.should respond_to service
    end
  end
  
  # service :category,
  #   processor: :categories,
  #     options: { :required => :id }
  it "should raise an error if the category contract is broken" do
    lambda{ @howcast.category :id => :id }.should_not raise_error ArgumentError
    
    lambda{ @howcast.category }.should raise_error ArgumentError
    lambda{ @howcast.category :x => :x }.should raise_error ArgumentError
    lambda{ @howcast.category :x }.should raise_error ArgumentError
    lambda{ @howcast.category :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.category :x, { :id => :id } }.should raise_error ArgumentError
  end
  
  # service :categories
  it "should raise an error if the categories contract is broken" do
    lambda{ @howcast.categories }.should_not raise_error ArgumentError
    
    lambda{ @howcast.categories :x }.should raise_error ArgumentError
    lambda{ @howcast.categories :x => :x }.should raise_error ArgumentError
    lambda{ @howcast.categories :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.categories :x => :x }.should raise_error ArgumentError
  end
  
  # service :search, 
  #    options: { :required => :query, :optional => { :view => :video } }
  it "should raise an error if the search contract is broken" do
    lambda{ @howcast.search :query =>:query }.should_not raise_error ArgumentError
    
    lambda{ @howcast.search }.should raise_error ArgumentError
    lambda{ @howcast.search :x =>:x }.should raise_error ArgumentError
    lambda{ @howcast.search :x }.should raise_error ArgumentError
    lambda{ @howcast.search :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.search :x, { :query => :query } }.should raise_error ArgumentError
  end

  # service :playlist,
  #   processor: :playlists,
  #     options: { :required => :id }
  it "should raise an error if the playlist contract is broken" do
    lambda{ @howcast.playlist :id => :id }.should_not raise_error ArgumentError
    
    lambda{ @howcast.playlist }.should raise_error ArgumentError
    lambda{ @howcast.playlist :x }.should raise_error ArgumentError
    lambda{ @howcast.playlist :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.playlist :x, { :id => :id } }.should raise_error ArgumentError
  end
  
  
  # service :video,
  #   processor: :videos,
  #     options: { :required => :id }
  it "should raise an error if the video contract is broken" do
    lambda{ @howcast.video :id => :id }.should_not raise_error ArgumentError
    
    lambda{ @howcast.video }.should raise_error ArgumentError
    lambda{ @howcast.video :x => :x }.should raise_error ArgumentError
    lambda{ @howcast.video :x }.should raise_error ArgumentError
    lambda{ @howcast.video :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.video :x, { :id => :id } }.should raise_error ArgumentError
  end
  
  
  # service :videos,
  #     options: { :required => [ :sort, :filter ],
  #                :optional => [ :category, :page ] }
  it "should raise an error if the videos contract is broken" do
    lambda{ @howcast.videos :sort => :sort, :filter => :filter }.should_not raise_error ArgumentError
    lambda{ @howcast.videos :sort => :sort, :filter => :filter, :category => :category }.should_not raise_error ArgumentError
    lambda{ @howcast.videos :sort => :sort, :filter => :filter, :page => :page }.should_not raise_error ArgumentError
    lambda{ @howcast.videos :sort => :sort, :filter => :filter, :category => :category, :page => :page }.should_not raise_error ArgumentError

    lambda{ @howcast.videos :sort => :sort }.should raise_error ArgumentError
    lambda{ @howcast.videos :filter => :filter }.should raise_error ArgumentError
    lambda{ @howcast.videos }.should raise_error ArgumentError
    lambda{ @howcast.videos :x }.should raise_error ArgumentError
    lambda{ @howcast.videos :x => :x }.should raise_error ArgumentError
    lambda{ @howcast.videos :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.videos :x, { :sort => :sort, :filter => :filter } }.should raise_error ArgumentError
  end
  
  # service :user,
  #   processor: :users,
  #     options: { :required => [ :id, :resource ] }
  it "should raise an error if the user contract is broken" do
    lambda{ @howcast.user :id => :id, :resource => :resource }.should_not raise_error ArgumentError

    lambda{ @howcast.user :id => :id }.should raise_error ArgumentError
    lambda{ @howcast.user :resource => :resource }.should raise_error ArgumentError
    lambda{ @howcast.user }.should raise_error ArgumentError
    lambda{ @howcast.user :x }.should raise_error ArgumentError
    lambda{ @howcast.user :x => :x }.should raise_error ArgumentError
    lambda{ @howcast.user :x, { :x => :x } }.should raise_error ArgumentError
    lambda{ @howcast.user :x, { :id => :id, :resource => :resource } }.should raise_error ArgumentError
  end
end
