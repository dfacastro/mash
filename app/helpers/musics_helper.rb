module MusicsHelper
  
  def music_ratings(music)
    if(music.total_ratings != 0)
      return "Rated " + music.average.to_s + " by " + pluralize(music.total_ratings, 'person')
    else
      return "No one has rated this sMash yet! Be the first to rate it!"
    end
    
  end
  
end
