## Background

Installed it as requirement for rust-analyser setup for nvim (https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/#set-up-rust-with-neovim)

## Setup

https://github.com/wbthomason/packer.nvim

```~/.config/nvim/lua/plugins.lua
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { "williamboman/mason.nvim" }
end)
```


- Files
```
~/.config/nvim/lua/plug.lua
~/workspace/github/my/configs/nvim/packer/nvim.in
```

- Lua embedded into .config/nvim/init.vim
```
lua <<EOF
require("mason").setup()
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
```

## Commmands

: PackerInstall
Run it after adding new plugin to  plugins.lua
