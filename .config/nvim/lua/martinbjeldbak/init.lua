require("martinbjeldbak.remap")
require("martinbjeldbak.set")
require("martinbjeldbak.filetype")

require("lazy").setup("martinbjeldbak.plugins", {
  change_detection = {
    notify = false,
  }
})
