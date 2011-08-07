class Entry < ActiveRecord::Base
  belongs_to :playlist
  has_one :music
end
