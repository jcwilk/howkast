require 'rubygems'
require 'howkast'
require 'yaml'

# configure
Howkast::configure YAML.load File.read('.howkast')

# create instance
howcast = Howkast::API.new

# alternative instantiation
# howcast = Howkast::API.new :api_key => 'YOUR-HOWCAST-API-KEY'

# search for jujitsu how-to videos
search = howcast.search :query => 'jujitsu'

# get detail for the first video listed in the search
video_id = search.videos.first.id
video    = howcast.video :id => video_id
puts video.title
puts video.embed

# find out what other videos where uploaded by the same user
username = video.username
user     = howcast.user :id => username, :resource => :videos
puts user.title
user.videos.each do |video|
  puts "- #{video.id}\t#{video.title}"
end

# list user's favorite videos
user = howcast.user :id => username, :resource => :favorites
puts user.title
user.videos.each do |video|
  puts "- #{video.id}\t#{video.title}\t#{video.description}"
end

# list user's playlists
user = howcast.user :id => username, :resource => :playlists
puts user.title
user.playlists.each do |video|
  puts "- #{video.id}\t#{video.title}"
end

# list available categories
categories = howcast.categories
categories.each do |category|
  puts "#{category.id}\t#{category.name}"
end

# get details about a category
category = howcast.category :id => categories.first.id
puts category.name
category.subcategories.each do |category|
  puts "- #{category.id}\t#{category.name}"
end

# list the videos in a playlist
playlist = howcast.playlist :id => '4261'
puts playlist.title
puts playlist.description
playlist.videos.each do |video|
  puts "- #{video.id}\t#{video.title}"
end
