#!/usr/bin/env ruby

# set this to true if we want to automatically copy the correctly spelled word to the clipboard.
# NOTE: Requires the 'xclip' binary on Linux.
$enable_copy_to_clipboard = true

require 'raspell'
require 'mattscilipoti-rdialog'
require 'oald_parser'

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


class Dictionary
  def initialize
    @speller = Aspell.new("en_US")
    @speller.set_option("ignore-case", "true")

    @facade = OaldParser::Facade.create_configured_instance
  end

  # return true if the word is spelled correctly
  def check(word)
    @speller.check(word)
  end

  # get an array of possible corrections
  def suggestions(word)
    @speller.suggest(word)
  end

  # look up a word in the Oxford Advanced Learners Dictionary
  def define(word)
    puts "Waiting for the definition of #{word}..."
    @facade.describe(str: word)
  end
end


class Dialog
  def initialize
    @dialog = RDialog.new
    @dialog.nocancel = true
    @dialog.shadow = false
  end

  def show_suggestions(original_word, suggestions)
    @dialog.menu("#{original_word} not found or spelled incorrectly.\n" +
                 "Select a word below to view the definition.",
                 suggestions.map { |s| [s] })
  end

  def show_definition(definition)
    @dialog.msgbox(definition)
  end
end


if ARGV.first.nil?
  abort("You must specify a word that you want to spell check or define")
else
  word = ARGV.first
  dictionary = Dictionary.new
  dialog = Dialog.new

  # if the user spelled the word right, just show the definition and tell them
  # they were right while we're waiting on the API.
  # otherwise, let them pick from a list of possible corrections, then show
  # the definition of the correctly-spelled word they picked.
  if dictionary.check(word)
    Clipboard.copy(word) if $enable_copy_to_clipboard

    puts "#{word} is spelled correctly."

    definition = dictionary.define(word)
    dialog.show_definition("#{word} is spelled correctly.\n\n#{word}:\n#{definition}")
  else
    suggestions = dictionary.suggestions(word)

    selected_word = dialog.show_suggestions(word, suggestions)

    Clipboard.copy(selected_word) if $enable_copy_to_clipboard

    definition = dictionary.define(selected_word)
    dialog.show_definition("#{selected_word}:\n#{definition}")
  end
end
