This gem implements Ruby bindings for the [Howcast](http://howcast.com) API.

Quickstart
----------

    # install
    gem install howkast
    
    # usage
    require 'howkast'

    # rock-n-roll
    howcast  = Howkast.new(:api_key => 'YOUR-HOWCAST-API-KEY')
    search   = howcast.query 'jujitsu'
    video_id = search.videos.first.id

    video    = howcast.video(:id => video_id)
    puts video.title
    puts video.embed
    
    username = video.username
    user     = howcast.user(:id => username, :resource => :videos)
    user.videos.each do |video|
      puts "#{video.id}\t#{video.title}"
      puts video.description
      puts
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
