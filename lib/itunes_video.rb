##
# The entire gem is contained in the Itunes_video class. 

class Itunes_video

  require 'pathname'
  require 'fileutils'

  attr_accessor :id, :kind, :category, :name, :genre, :year, :description, :long_description, :comment, :unplayed, :played_count, :rating, :artwork, :season_num, :episode_num, :show_name
  
  ##
  # The initialize method imports the video into iTunes and returns an iTunes
  # track ID, which is used to identify the video for the other methods. 
  
  def initialize(file)
    if !(Pathname.new file).absolute?
      if File.exist?(File.join(FileUtils.pwd, file))
        file = File.join(FileUtils.pwd, file)
      else
        raise "could not find video to import"
      end
    end
    import = `osascript -e 'tell application \"iTunes\" to add POSIX file \"#{file}\"'`
    if import.split(" ")[3].nil?
      raise "could not import video"
    else
      @id = import.split(" ")[3]
    end
  end
  
  ##
  # Set the 'kind' for the video. 
  # Must be one of ["tv show", "movie", "music video", "none"]

  def kind=(kind)
    kinds = ["tv show", "movie", "music video", "none"]
    if !kinds.include?(kind)
      raise "video kind must be one of: #{kinds.join(', ')}"
    else
      if `osascript -e 'tell application \"iTunes\" to set video kind of file track id #{@id} to #{kind}'`
        @kind = kind
      else
        raise "could not set 'kind' for video"
      end
    end
  end
  
  ##
  # Set the 'category' for the video. 

  def category=(category)
    if `osascript -e 'tell application \"iTunes\" to set category of file track id #{@id} to \"#{category}\"'`
      @category = category
    else
      raise "could not set 'category' for video"
    end
  end

  ##
  # Set the 'name' for the video. 
  # Sets episode name for a video of kind 'tv show' 
  # Sets movie title for a video of kind 'movie'
  
  def name=(name)
    if `osascript -e 'tell application \"iTunes\" to set name of file track id #{@id} to \"#{name}\"'` 
      @name = name
    else
      raise "could not set 'name' for video"
    end
  end
  
  ##
  # Set the 'genre' for the video. 

  def genre=(genre)
    if `osascript -e 'tell application \"iTunes\" to set genre of file track id #{@id} to \"#{genre}\"'` 
      @genre = genre
    else
      raise "could not set 'genre' for video"
    end
  end
  
  ##
  # Set the 'year' for the video. 
  # Must be a four digit number or a string with four numbers. 

  def year=(year)
    year = year.to_s
    if !(year =~ /^\d{4}$/)
      raise "year must be a four-digit number"
    elsif `osascript -e 'tell application \"iTunes\" to set year of file track id #{@id} to \"#{year}\"'` 
      @year = year
    else 
      raise "could not set 'year' for video"
    end
  end
  
  ##
  # Set the 'description' for the video. 

  def description=(desc)
    if `osascript -e 'tell application \"iTunes\" to set description of file track id #{@id} to \"#{desc}\"'` 
      @description = desc
    else
      raise "could not set 'description' for video"
    end
  end
  
  ##
  # Set the 'long description' for the video. 
  
  def long_description=(long_desc)
    if `osascript -e 'tell application \"iTunes\" to set long description of file track id #{@id} to \"#{long_desc}\"'` 
      @long_description = long_desc
    else
      raise "could not set 'long description' for video"
    end
  end
  
  ##
  # Set the 'comment' for the video. 

  def comment=(comment)
    if `osascript -e 'tell application \"iTunes\" to set comment of file track id #{@id} to \"#{comment}\"'` 
      @comment = comment
    else 
      raise "could not set 'comment' for video"
    end  
  end

  ##
  # Set 'uplayed' for the video. 
  # Must be either 'true' or 'false'

  def unplayed=(unplayed)
    if ![true, false].include? unplayed
      raise TypeError, "unplayed must be 'true' or 'false'"
    elsif  `osascript -e 'tell application \"iTunes\" to set unplayed of file track id #{@id} to \"#{unplayed}\"'` 
      @unplayed = unplayed
    else 
      raise "could not set 'unplayed' for video"
    end
  end
  
  ##
  # Set the 'played count' for the video. 

  def played_count=(played_count)
    if `osascript -e 'tell application \"iTunes\" to set played count of file track id #{@id} to #{played_count.to_i}'`
      @played_count = played_count
    else
      raise "could not set 'played count' for video"
    end
  end
  
  ##
  # Set the 'rating' for the video. 
  # Must be a number between 0 and 100.

  def rating=(rating)
    if !rating.to_i.between?(0,100)
      raise "rating must be between 0 and 100"
    elsif `osascript -e 'tell application \"iTunes\" to set rating of file track id #{@id} to #{rating.to_i}'`
      @rating = rating
    else  
      raise "could not set 'rating' for video"
    end
  end
  
  ##
  # A list of file formats that Image Events can read from is as follows:
  # PICT, Photoshop, BMP, QuickTime Image, GIF, JPEG, MacPaint, JPEG2, SGI, PSD, TGA, Text, PDF, PNG, and TIFF. 
  # Trying to set artwork not of one of these types will throw a -206 error.
  
  def artwork=(artwork)
    if !File.exists?(artwork)
      raise "file '#{artwork}' does not exist"
    elsif 
      `osascript <<EOF
      tell application "iTunes"
         set the_artwork to read (POSIX file \"#{artwork}\") as picture
         set data of artwork 1 of file track id #{@id} to the_artwork
      end tell
      EOF`
      @artwork = artwork
    else  
      raise "could not set 'artwork' for video"
    end
  end
  
  # :section: tv show-specific methods
  
  ##
  # Set the 'season number' for a video of type 'tv show'. 
  
  def season_num=(season_num)
    if `osascript -e 'tell application \"iTunes\" to set season number of file track id #{@id} to #{season_num.to_i}'`
      @season_num = season_num
    else
      raise "could not set 'season number' for video"
    end
  end

  ##
  # Set the 'episode number' for a video of type 'tv show'. 
  
  def episode_num=(episode_num)
    if `osascript -e 'tell application \"iTunes\" to set episode number of file track id #{@id} to \"#{episode_num.to_i}\"'`
      @episode_num = episode_num
    else
      raise "could not set 'episode number' for video"
    end
  end

  ##
  # Set the 'show name' for a video of type 'tv show'. 
  
  def show_name=(show_name)
    if `osascript -e 'tell application \"iTunes\" to set show of file track id #{@id} to \"#{show_name}\"'` 
      @show_name = show_name
    else
      raise "could not set 'show name' for video"
    end
  end

end
