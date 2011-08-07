class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :entries, :dependent => :destroy

  def has_entry(music_id)
    self.entries.select(:music_id).map(&:music_id).include? music_id.to_i
  end

  def delete_entry(music_id)
    @entry = self.entries.find_by_music_id(music_id)
    @order_no = @entry.order_no
    @entry.destroy

    self.entries.where(["order_no > ?", @order_no ]).each do |en|
      en.order_no -= 1
      en.save
    end
  end

  def add_entry(music_id)
    if self.entries.count.zero?
      @order_no = 1
    else
      @order_no = self.entries.maximum(:order_no) + 1
    end
    self.entries.build(:music_id => music_id, :order_no => @order_no)
  end


  def update_entry(music_id)
    if self.entries.select(:music_id).map(&:music_id).include? music_id.to_i
       puts '**************** CONTEM'
       puts music_id
       self.entries.select(:music_id).map(&:music_id).each do |e| puts e  end
      #apagar musica, resort da ordem as musicas restantes
      @entry = self.entries.find_by_music_id(music_id)
      @order_no = @entry.order_no
      @entry.destroy

      self.entries.where(["order_no > ?", @order_no ]).each do |en|
        en.order_no -= 1
        en.save
      end

    else #musica ainda nao foi adicionada
      puts '**************** NAO CONTEM'
      puts music_id
      self.entries.select(:music_id).map(&:music_id).each do |e| puts e  end
      puts self.entries.select(:music_id).map(&:music_id).include? music_id.to_i
      #primeira entrada
      if self.entries.count.zero?
        @order_no = 1
      else
        @order_no = self.entries.maximum(:order_no) + 1
      end
      self.entries.build(:music_id => music_id, :order_no => @order_no)

    end
  end

end
