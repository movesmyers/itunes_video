### itunes_video: a gem to import and organize your video collection in iTunes. Mac OS X only.

### Build from source:

```bash
gem build itunes_video.gemspec
sudo gem install ./itunes_video-x.x.x.gem
```

### Usage:

```ruby
require 'itunes_video'

v = Itunes_video.new("/path/to/video.mp4")
v.kind = "tv show"
v.season_num = 2

p v.kind # => "tv show"
p v.season_num # => 2
```

See itunes_video.rb for the full list.
