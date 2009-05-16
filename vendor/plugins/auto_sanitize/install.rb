# Install hook code here
#
# If the configuration file is missing, copy the template to the appropriate
# place in config/initializers.
#
unless File.exists? RAILS_ROOT + '/config/initializers/auto_sanitize.rb'
  require 'fileutils'
  FileUtils::cp File.dirname(__FILE__) + '/../templates/auto_sanitize.rb', 
                RAILS_ROOT + '/config/initializers/auto_sanitize.rb'
end
