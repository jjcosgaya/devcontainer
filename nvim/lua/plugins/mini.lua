return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require("mini.surround").setup()
    require("mini.pairs").setup()
    local splitjoinOpts = {
      mappings = {
        toggle = 'gj'
      }
    }
    require("mini.splitjoin").setup(splitjoinOpts)
  end
}
