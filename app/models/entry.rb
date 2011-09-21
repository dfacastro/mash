class Entry < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :music
  default_scope :order => 'order_no'
end
