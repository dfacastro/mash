class UpdateMusicsAverages < ActiveRecord::Migration
  def up
    Music.all.each do |m|
      m.calculate_average
      m.save!
    end
  end

  def down
  end
end
