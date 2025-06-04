map = require 'scripts.keymapper'
git = require 'scripts.git'
builtin = require 'telescope.builtin'

keylist = require 'config.keylist'

local keymap = {
  copilot = map:parse(keylist.copilot),
  diffview = map:parse(keylist.diffview),
  figutive = map:parse(keylist.fugitive),
  ranger = map:parse(keylist.ranger),
  repl = map:parse(keylist.repl),
  spectre = map:parse(keylist.spectre),
  telescope = map:parse(keylist.telescope),
}

return keymap
