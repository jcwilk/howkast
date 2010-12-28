This gem implements Ruby bindings for the [Howcast](http://howcast.com) API.

Quickstart
----------

    # install
    gem install howkast
    
    # usage (see also sample/quickstart.rb)
    require 'howkast'

    # configure
    Howkast::configure :api_key => 'YOUR-HOWCAST-API-KEY'
    
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
    user.videos.each do |video|
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
    
Download
--------
You can download this project in either
[zip](http://github.com/jurisgalang/howkast/zipball/master) or
[tar](http://github.com/jurisgalang/howkast/tarball/master") formats.

You can also clone the project with [Git](http://git-scm.com)
by running: 

    git clone git://github.com/jurisgalang/howkast

Note on Patches/Pull Requests
-----------------------------
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version 
  unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have 
  your own version, that is fine but bump version in a commit by itself I can 
  ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Releases
--------
Please read the `RELEASENOTES` file for the details of each release. 

In general: patch releases will not include breaking changes while releases 
that bumps the major or minor components of the version string may or may not 
include breaking changes.

Author
------
[Juris Galang](http://github.com/jurisgalang/)

License
-------
Dual licensed under the MIT or GPL Version 2 licenses.  
See the MIT-LICENSE and GPL-LICENSE files for details.

Copyright (c) 2010 Juris Galang. All Rights Reserved.
