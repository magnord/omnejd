module Tidier

  require 'tidy'

  # Modify the tidy_path for Mac OSX only
  require 'open3'
  if FileTest.exists?("/usr/bin/uname") && Open3.popen3("/usr/bin/uname") do |i,o,e| o.read end.strip == "Darwin"
    Tidy.path = '/usr/lib/libtidy.dylib'
  else
    Tidy.path = '/usr/lib/libtidy.so'
  end

  # Create a special tidier for our use
  TIDIER = Tidy.new
  TIDIER.options.show_errors = 0
  TIDIER.options.show_warnings = false
  TIDIER.options.force_output = true
  TIDIER.options.show_body_only = true
  TIDIER.options.char_encoding = 'utf8'
  TIDIER.options.input_encoding = 'utf8'
  TIDIER.options.output_encoding = 'utf8'
  TIDIER.options.output_xhtml = true
  TIDIER.options.indent = 'auto'
  TIDIER.options.wrap = 0
  
end