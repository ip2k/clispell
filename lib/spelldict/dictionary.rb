# encoding: UTF-8
module Dictionary
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
end
