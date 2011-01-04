require 'rubygems'
require 'yaml'
begin
  require 'howkast'
rescue LoadError
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  require 'howkast'
end

Howkast::configure YAML.load File.read('.howkast')
howcast = Howkast::API.new
video   = howcast.video :id => 3907
puts video.category_hierarchy.first.name

video   = howcast.video :id => 5072
puts video.category_hierarchy
puts video.category_hierarchy.first.name

#search  = howcast.search :query => 'jujitus'
#puts search.videos.count
#
#search  = howcast.search :query => 'jujitsu'
#puts search.videos.count
#
#search  = howcast.search :query => ''
#puts search.videos.count
#search.videos.each do |video|
#  puts video.title
#end
