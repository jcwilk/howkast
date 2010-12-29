This gem implements Ruby bindings for the [Howcast](http://howcast.com) API.

Quickstart Guide
----------------

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

Services
--------
To get identify what services are supported, you can invoke the `services`
class method from the `Howkast::API` class:

    Howkast::API.services  # => [:video, :videos, :search, :user, :playlist, :category, :categories]
  
At the time of this writing, this gem implements all of the services listed in 
the [Howcast API Documentation](http://groups.google.com/group/howcast-developers/web/api-documentation)

The current implementation is that each service expects a `Hash` that names 
the parameters required to fulfill the request. The acceptable parameters
(with a minor adjustments to make the parameter names consistent) closely
match the documented service signatures.

Here are some examples to illustrate the service calls. Notice also that the 
`format` parameter is not required, while the `api_key` needs to be set via
the configuration or when the `Howkast` object is created:

    # get video
    GET http://www.howcast.com/videos/<video_id>.<format>?api_key=<api_key>
    
    # service method call
    howcast.video :id => 6570
    
    # list videos
    GET http://www.howcast.com/videos/<sort>/<filter>/<category>.<format>?api_key=<api_key>
    
    # service method call
    howcast.videos :sort => :top_rated, :filter => :howcast_studios, :page => 5

    # search videos
    GET http://www.howcast.com/search.<format>?q=<query>&view=video&api_key=<api_key> 
  
    # service method call
    howcast.search :query => 'jujitsu'
    
    # list top level categories
    GET http://www.howcast.com/categories.<format>?api_key=<api_key>    

    # service method call
    howcast.categories

Read the [Howcast API Documentation](http://groups.google.com/group/howcast-developers/web/api-documentation)
for details.

Models
------
The return value of a service request is an instance of `Howkast::Model` - the
actual type returned depends on the service invoked. 

The rule to determine the type of the response is:

1. The name of the service in singular form dictates the name of the model 
   (eg: `video` returns `Howkast::Model::Video`)
2. If the service name is in plural form, then an `Array` of the expected
   model is returned.
   
The `Howkast::Model` instance returned will have the appropriate attributes
as described in the [Howcast API Documentation](http://groups.google.com/group/howcast-developers/web/api-documentation)

You can examine the list of attributes by invoking the `#instance_attributes`
method of the returned model:

    video = howcast.video :id => 6570
    video.class                # => Howkast::Model::Video
    video.instance_attributes  # => [:id, :category_id, :category_hierarchy, :easy_steps, :badges, :created_at, :filename, :tags, :title, :description, :permalink, :edit_url, :state, :duration, :width, :height, :embed, :rating, :username, :thumbnail_url, :views, :content_rating, :overlay, :ingredients, :markers, :related_videos, :comments]

And of course examine each attribute as needed:

    video.category_hierarchy   # => ["Cars & Transportation", "Car Safety", "Defensive Driving"]
    video.title                # => "How To Drive a Stick Shift" 
    video.related_videos       # => Array of Howkast::Model::Video

Errors
------
If a service request fails then a `Howkast::Error::RequestError` error type is
raised.

Read the **HTTP Status Codes and Errors** section of the [Howcast API Documentation](http://groups.google.com/group/howcast-developers/web/api-documentation)
for the types of errors that may encounter.
    

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
