class Itunes_video

  require 'pathname'
  require 'fileutils'

  attr_accessor :id, :kind, :category, :name, :genre, :year, :description, :long_description, :comment, :unplayed, :played_count, :rating, :season_num, :episode_num, :show_name
  
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

  def kind=(kind)
    kinds = ["tv show", "movie", "music video", "none"]
    if !kinds.include?(kind)
      raise "video kind must be one of: #{kinds}"
    else
      if `osascript -e 'tell application \"iTunes\" to set video kind of file track id #{@id} to #{kind}'`
        @kind = kind
      else
        raise "could not set 'kind' for video"
      end
    end
  end

  def category=(category)
    if `osascript -e 'tell application \"iTunes\" to set category of file track id #{@id} to \"#{category}\"'`
      @category = category
    else
      raise "could not set 'category' for video"
    end
  end

  # sets episode name for tv show or movie title for movie
  def name=(name)
    if `osascript -e 'tell application \"iTunes\" to set name of file track id #{@id} to \"#{name}\"'` 
      @name = name
    else
      raise "could not set 'name' for video"
    end
  end

  def genre=(genre)
    if `osascript -e 'tell application \"iTunes\" to set genre of file track id #{@id} to \"#{genre}\"'` 
      @genre = genre
    else
      raise "could not set 'genre' for video"
    end
  end

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

  def description=(desc)
    if `osascript -e 'tell application \"iTunes\" to set description of file track id #{@id} to \"#{desc}\"'` 
      @description = desc
    else
      raise "could not set 'description' for video"
    end
  end
  
  def long_description=(long_desc)
    if `osascript -e 'tell application \"iTunes\" to set long description of file track id #{@id} to \"#{long_desc}\"'` 
      @long_description = long_desc
    else
      raise "could not set 'long description' for video"
    end
  end

  def comment=(comment)
    if `osascript -e 'tell application \"iTunes\" to set comment of file track id #{@id} to \"#{comment}\"'` 
      @comment = comment
    else 
      raise "could not set 'comment' for video"
    end  
  end

  def unplayed=(unplayed)
    unplayed = unplayed.downcase
    if !["true", "false"].include? unplayed
      raise TypeError, "unplayed must be 'true' or 'false'"
    elsif  `osascript -e 'tell application \"iTunes\" to set unplayed of file track id #{@id} to \"#{unplayed}\"'` 
      @unplayed = unplayed
    else 
      raise "could not set 'unplayed' for video"
    end
  end

  def played_count=(played_count)
    if `osascript -e 'tell application \"iTunes\" to set played count of file track id #{@id} to #{played_count.to_i}'`
      @played_count = played_count
    else
      raise "could not set 'played count' for video"
    end
  end

  def rating=(rating)
    if !rating.to_i.between?(0,100)
      raise "rating must be between 0 and 100"
    elsif `osascript -e 'tell application \"iTunes\" to set rating of file track id #{@id} to #{rating.to_i}'`
      @rating = rating
    else  
      raise "could not set 'rating' for video"
    end
  end

  # tv show specific methods
  def season_num=(season_num)
    if `osascript -e 'tell application \"iTunes\" to set season number of file track id #{@id} to #{season_num.to_i}'`
      @season_num = season_num
    else
      raise "could not set 'season number' for video"
    end
  end

  def episode_num=(episode_num)
    if `osascript -e 'tell application \"iTunes\" to set episode number of file track id #{@id} to \"#{episode_num.to_i}\"'`
      @episode_num = episode_num
    else
      raise "could not set 'episode number' for video"
    end
  end

  def show_name=(show_name)
    if `osascript -e 'tell application \"iTunes\" to set show of file track id #{@id} to \"#{show_name}\"'` 
      @show_name = show_name
    else
      raise "could not set 'show name' for video"
    end
  end

end
