require "mp3info"


class Music < ActiveRecord::Base
  
  belongs_to :user
  has_many :ratings, :dependent => :destroy
  
  
  before_create :validate_file
  before_save :calculate_average

  validates :filename, :uniqueness => true
  validates :title, :author, :presence => true

  attr_accessor :file
  
  public
  
  def get_length
    (self.length/60).to_s + ':' + (self.length%60).to_s
  end
  
  def calculate_average
    self.average = Rating.where(:music_id => self.id).average(:stars) || 0
    self.total_ratings = Rating.where(:music_id => self.id).count
  end


  private
  
  def gen_filename
    #define your rename file method
    Time.now.to_i.to_s    
  end
  
  def validate_file
    begin
      
      if file.blank?
        errors.add(:file, 'was not specified')
        return false
      end

      filename = gen_filename
      return false if filename.nil?

      extension = File.extname(file.original_filename)
      if extension.nil?
        errors.add(:file,"with no extension")
        return false
      end

      # Check if the FILE_TEMP_PATH is created, if not try to create
      if !File.directory?(FILE_TEMP_PATH)
        File.makedirs(FILE_TEMP_PATH)
      end

      temp_source = File.join(FILE_TEMP_PATH, filename)
      temp_source << extension
      final_source = File.join(FILE_ROOT_PATH, filename)
      final_source << extension

      File.open(temp_source, "wb") { |f| f.write(file.read)}
      size=File.size(temp_source)
      extension = File.extname(temp_source)
=begin
      mime_extension=File.mime_type?(temp_source)
puts mime_extension
      if FILE_MIME_EXTENSIONS.include?(mime_extension) == false
        logger.error("Trying to upload file with mime-type: #{mime_extension} ")
        errors.add(:file_data,"Only wav, mp3,gsm and pdf files are allowed")
      return false
      end
=end

      if FILE_EXTENSIONS.include?(extension) == false
        logger.error("Trying to upload file with extension: #{extension} ")
        errors.add(:file,"extension should be mp3 or ogg")
        FileUtils.rm(temp_source)
        return false
      end

      if size > FILE_MAXIMUM_SIZE_FOR_FILE
        logger.error("Trying to upload file with size: #{size} ")
        errors.add(:file,"should not have more than #{FILE_MAXIMUM_SIZE_FOR_FILE} bytes")
        FileUtils.rm(temp_source)
        return false
      end
  
      if valid? #Upload in permanent folder
        logger.error("#{self.errors.to_xml}")
        self.filename=filename
        self.filename << extension
        self.length = Mp3Info.open(temp_source).length
        FileUtils.copy_file(temp_source,final_source)
        FileUtils.rm(temp_source) if File.exists?(temp_source)
        return true
      else
        errors.add(:file_data,"Invalid file format")
        FileUtils.rm(temp_source) #Remove temp file
        return false
      end

    rescue => e
      logger.error(e)
      errors.add(:file,": Invalid file format")
    return false
    end

  end

end
