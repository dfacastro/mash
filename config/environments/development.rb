Mash::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false
  
  FILE_EXTENSIONS = [".png",".gif",".jpg",".jpeg", ".mp3"] #Allowed file types
 
  FILE_TEMP_PATH="#{Rails.root.to_s}/public/temp/" #Where file is initialy uploaded
 
  FILE_MIME_EXTENSIONS =["audio/x-wav","audio/mpeg","audio/gsm","audio/x-gsm","application/pdf", "image/png", "image/gif", "image/jpeg"] #Allowed file types
   
  FILE_ROOT_PATH= "#{Rails.root.to_s}/public/saved/" #Where file is uploaded permanently
   
  FILE_MAXIMUM_SIZE_FOR_FILE=10048576 #Maximum Size (1MB) define in bytes
end
