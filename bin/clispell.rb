#!/usr/bin/env ruby
require 'raspell'

speller = Aspell.new("en_US")
speller.set_option("ignore-case", "true")

if !speller.check('testa')
   suggestions = speller.suggest('testa')
   puts suggestions
   puts suggestions.class
end
