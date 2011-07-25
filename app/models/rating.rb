class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :music
  after_save :update_musics_average
  
  validates_uniqueness_of :music_id, :scope => :user_id #par (musica, user) é unico
  validate :number_of_stars
  
  def update_musics_average
    self.music.save
  end
  
  def number_of_stars
    errors.add(:stars, 'should be between 1 and 5') unless self.stars >= 1 and self.stars <= 5
  end
  
end
