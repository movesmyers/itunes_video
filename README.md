### itunes_video: a gem to import and organize your video collection in iTunes. Mac OS X only.

### build from source:

```bash
gem build itunes_video.gemspec
sudo gem install ./itunes_video-x.x.x.gem
```

### usage:

```ruby
require 'itunes_video'

v = Itunes_video.new("/path/to/video.mp4")
v.kind = "tv show"
v.season_num = 2

p v.kind # => "tv show"
p v.season_num # => 2
```

see itunes_video.rb for the full list.
