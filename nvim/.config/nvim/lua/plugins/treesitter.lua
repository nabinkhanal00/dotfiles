return {
  'nvim-treesitter/nvim-treesitter',
  init = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end
}

