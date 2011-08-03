# encoding: UTF-8
module Spelldict
    module Dialog
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
    extend Dialog
end

