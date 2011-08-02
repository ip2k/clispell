# set this to true if we want to automatically copy the...
# ...correctly spelled word to the clipboard.
# NOTE: Requires the 'xclip' binary on Linux.
enable_copy_to_clipboard = true

if enable_copy_to_clipboard
    require 'clipboard'
    # if we're running on Linux, make sure that 'xclip' is available...
    # ...and quit if it isn't since clipboard won't work without it.
    if RUBY_PLATFORM.include?("linux")
        xclip = `which xclip`.strip
        if xclip.empty?
            abort("You need the 'xclip' binary for copy-to-clipboard functionality to work properly under Linux")
        end
    end
    Clipboard.copy("test123")
    puts Clipboard.paste
end
