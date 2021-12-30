# telescope-cd

Fuzzy changing the current working directory.  

## What does it do?

Provides a picker for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), which lets you set the current working directory.  

All subdirectories of the project-directory including the project-directory act as items for the finder.  
Even if the cwd is a subdirectory the parent directories are still items of the finder.  

The project-directory is the directory from where Nvim was launched.  

## Installation

Make sure that `scripts/cdfs.sh` is in your path.  

Add the following to your `telescope.setup.extensions` in your config file:  

```lua
cd = {
	project_dir = vim.fn.getcwd()
},
```

Add the following mapping to your config file:  

```vim
nnoremap <leader>C <cmd>lua require('telescope').load_extension('cd').find_dirs()<cr>
```
