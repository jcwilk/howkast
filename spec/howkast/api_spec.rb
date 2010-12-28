require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Howkast::API" do
  API_KEY1 = '6c6d1613339399efd0bc74fe12b14dd370b3ac76'
  API_KEY2 = 'bec946eaa53dc4e0527b28917f318fcd70b3ac76'
  
  before :all do
    @config ||= YAML.load File.read(File.expand_path(File.dirname(__FILE__) + '/../../.howkast'))
    Howkast::configure @config
    @howcast = Howkast::API.new
  end
  
  it "should honor configuration" do
    Howkast::configure :api_key => API_KEY1
    howcast = Howkast::API.new
    howcast.configuration.api_key.should eql API_KEY1
  end

  it "should be able to override configuration" do
    Howkast::configure :api_key => API_KEY1
    howcast = Howkast::API.new api_key: API_KEY2
    howcast.configuration.api_key.should eql API_KEY2
  end
  
  #it "should be able to query shit" do
  #  config = YAML.load File.read('.howkast')
  #  Howkast::configure config
  #  howcast = Howkast::API.new
  #  begin
  #    puts
  #    puts howcast.video :id => 6570
  #    #puts "#{video.title} / #{video.category_hierarchy}"
  #    #
  #    puts howcast.videos :sort => :top_rated,   :filter => :all
  #    #videos.each do |video|
  #    #  puts "#{video.title} / #{video.category_hierarchy}"
  #    #end
  #    puts howcast.videos :sort => :top_rated,   :filter => :howcast_studios, :category => :'1-Arts-and-Media'
  #    puts howcast.videos :sort => :most_viewed, :filter => :all, :page => 1
  #    puts howcast.videos :sort => :most_viewed, :filter => :all, :category => :'9-Film-Video-and-Television', :page => 1
  #    #
  #    puts howcast.search :query => 'kupal'
  #    #puts "#{search.title}"
  #    #puts search.videos
  #    #
  #    puts howcast.search :query => 'jujitsu'
  #    #puts "#{search.title}"
  #    #puts search.videos
  #    #
  #    puts howcast.user :id => 'howcast', :resource => :playlists
  #    puts howcast.user :id => 'wogelife', :resource => :'favorites/videos'
  #    puts howcast.user :id => 'howcast_guitar_lessons', :resource => :playlists
  #    #puts "[#{user.title}]"
  #    #user.playlists.each do |playlist|
  #    #  puts "#{playlist.id}\t#{playlist.title}\t#{playlist.rating}\t#{playlist.videos_count}\t#{playlist.views}"
  #    #end
  #    # 
  #    puts howcast.user :id => 'milkhouse', :resource => :playlists
  #    puts howcast.user :id => 'jurisgalang', :resource => :playlists
  #    #puts "[#{user.title}]"
  #    #puts user.playlists.class
  #    #user.playlists.each do |playlist|
  #    #  puts "#{playlist.id}\t#{playlist.title}\t#{playlist.rating}\t#{playlist.videos_count}\t#{playlist.views}"
  #    #end
  #    #
  #    puts howcast.user :id => 'jurisgalang', :resource => :favorites
  #    #puts "[#{user.title}]"
  #    #puts user.videos.class
  #    #     
  #    puts howcast.user :id => 'Milkhouse', :resource => :videos
  #    #puts user.title
  #    #puts user.videos
  #    #
  #    puts howcast.user :id => 'milkhouse', :resource => :favorites
  #    #puts user.title
  #    #puts user.videos
  #    #puts user.title
  #    #puts user.videos
  #    puts howcast.user :id => 'jurisgalang', :resource => :videos
  #    puts howcast.user :id => 'kreektrebano', :resource => :videos
  #    #
  #    puts howcast.playlist :id => '8508'
  #    #puts playlist.title
  #    #playlist.videos.each do |video|
  #    #  puts video.title
  #    #end
  #    
  #    puts howcast.playlist :id => '4261'
  #    #howcast.playlist :id => '4261'
  #    #
  #    puts howcast.category :id => 9
  #    puts howcast.category :id => :'9-Film-Video-and-Television'
  #    puts howcast.category(:id => 1105)
  #    #
  #    puts howcast.categories.each
  #    #
  #    puts howcast.user :id => 'kreektrebano', :resource => :playlists
  #  rescue => e
  #    puts "#{e.class} / #{e.message}"
  #    #puts e.backtrace
  #  end
  #end
end
