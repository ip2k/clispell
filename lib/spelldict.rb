%w(
raspell
mattscilipoti-rdialog
oald_parser
).each { |lib| require lib }

Thread.abort_on_exception = true
Encoding.default_external = Encoding.find('UTF-8')

if $enable_copy_to_clipboard
  require 'clipboard'

  # if we're running on Linux, make sure that 'xclip' is available
  if RUBY_PLATFORM.include?("linux")
    xclip = `which xclip`.strip
    if xclip.empty?
      abort("You need the 'xclip' binary for copy-to-clipboard " +
            "functionality to work properly under Linux")
    end 
  end 
end


%w(
dictionary
dialog
).each { |name| require_dependency File.expand_path("../spelldict/#{name}", __FILE__) }
